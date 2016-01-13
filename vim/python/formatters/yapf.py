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


def Yapf(start, end):
    # Get the current text.
    buf = vim.current.buffer
    text = "\n".join(buf)

    command = [BINARY]

    with TemporaryDirectory() as temp_dir_path:
        tempfile_path = os.path.join(temp_dir_path,
                                     os.path.basename(vim.current.buffer.name))
        with open(tempfile_path, "ab+") as f:
            f.write(text)

        command += ["-l", '%s-%s' % (start + 1, end + 1), ]
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
        lines = stdout.splitlines()
        sequence = difflib.SequenceMatcher(None, vim.current.buffer, lines)
        for op, i1, i2, j1, j2 in reversed(sequence.get_opcodes()):
            if op == 'equal':
                continue

            whitespace_only = True
            for k in xrange(max(i2 - i1, j2 - j1)):
                line_a = buf[i1 + k] if k < i2 - i1 else ''
                line_b = lines[j1 + k] if k < j2 - j1 else ''
                whitespace_only = line_a.strip() == line_b.strip()
                if not whitespace_only:
                    break

            if i1 <= end and i2 >= start or not whitespace_only:
                buf[i1:i2] = lines[j1:j2]
    else:
        print('ERROR: No output from %r' % (command, ))
