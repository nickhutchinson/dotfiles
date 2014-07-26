import difflib
import subprocess
import sys
import vim

BINARY = 'autopep8'

def _Win32StartupInfo():
    startupinfo = None
    if sys.platform.startswith('win32'):
        startupinfo = subprocess.STARTUPINFO()
        startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
        startupinfo.wShowWindow = subprocess.SW_HIDE

    return startupinfo


def AutoPep8(start=None, end=None):
    # Get the current text.
    buf = vim.current.buffer
    text = '\n'.join(buf)

    command = [BINARY]

    # Determine range to format.
    command += ["--range"]

    if not start or not end:
        command += [str(vim.current.range.start + 1),
                    str(vim.current.range.end + 1)]
    else:
        command += [str(start), str(end)]

    command += ['--indent-size', str(buf.options['shiftwidth'])]
    command += ['--aggressive', '--aggressive']
    command += ['-']

    p = subprocess.Popen(
        command,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        stdin=subprocess.PIPE,
        startupinfo=_Win32StartupInfo())
    stdout, stderr = p.communicate(input=text)

    # If successful, replace buffer contents.
    if stderr:
        print(stderr)

    if not stdout:
        print('No output from autopep8; command was {0}'.format(command))
    else:
        lines = stdout.split('\n')
        sequence = difflib.SequenceMatcher(None, vim.current.buffer, lines)
        for op in reversed(sequence.get_opcodes()):
            if op[0] is not 'equal':
                vim.current.buffer[op[1]:op[2]] = lines[op[3]:op[4]]


