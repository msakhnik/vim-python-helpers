try:
    import vim
except ImportError:
    vim = None


def _do_replacement(line: str) -> str:
    """
    The function replaces double quotes with single quotes
    """
    result = ''
    line = line.replace("'", "\'")
    for i in range(len(line)):
        if line[i] == '"':
            for index in [i + 1, i - 1]:
                if 0 <= index < len(line):
                    if line[index] == '"':
                        result += '"'
                        break
            else:
                result += '\''
        elif line[i] == '\'':
            result += '\\\''
        else:
            result += line[i]
    return result


def replace_double_with_single_quotes():
    for i, line in enumerate(vim.buffers[1]):
        new_line = _do_replacement(line)
        vim.buffers[1][i] = new_line


assert _do_replacement('"Hello world"') == '\'Hello world\''
assert _do_replacement('"Hello vim\'s world"') == '\'Hello vim\\\'s world\''
assert _do_replacement('"""Hello vim\'s world"""') == '"""Hello vim\\\'s world"""'
