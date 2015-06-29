import contextlib
import difflib
import shutil
import os
import subprocess
import sys
import tempfile
import vim

BINARY = 'yapf'


def _Win32StartupInfo():
    startupinfo = None
    if sys.platform.startswith('win32'):
        startupinfo = subprocess.STARTUPINFO()
        startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
        startupinfo.wShowWindow = subprocess.SW_HIDE

    return startupinfo


@contextlib.contextmanager
def TemporaryDirectory(delete=True, *args, **kwargs):
    path = tempfile.mkdtemp(*args, **kwargs)
    try:
        yield path
    finally:
        if delete:
            shutil.rmtree(path)


def Yapf(start=None, end=None):
    # Get the current text.
    buf = vim.current.buffer
    text = "\n".join(buf)

    command = [BINARY]

    # Determine range to format.
    if not start or not end:
        lines = '%s-%s' % (vim.current.range.start + 1,
                           vim.current.range.end + 1)
    else:
        lines = '%s-%s' % (start, end)

    with TemporaryDirectory() as temp_dir_path:
        tempfile_path = os.path.join(temp_dir_path,
                                     os.path.basename(vim.current.buffer.name))
        with open(tempfile_path, "wb") as f:
            f.write(text)

        command += ["-l", lines]
        command += ['--style={indent_width: %d}' % buf.options['shiftwidth']]
        command += [tempfile_path]

        p = subprocess.Popen(command,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE,
                             stdin=subprocess.PIPE,
                             startupinfo=_Win32StartupInfo())
        stdout, stderr = p.communicate()

    # If successful, replace buffer contents.
    if stdout:
        lines = stdout.split('\n')
        sequence = difflib.SequenceMatcher(None, vim.current.buffer, lines)
        for op in reversed(sequence.get_opcodes()):
            if op[0] is not 'equal':
                vim.current.buffer[op[1]:op[2]] = lines[op[3]:op[4]]
    else:
        print('ERROR: No output from %r' % (command, ))
