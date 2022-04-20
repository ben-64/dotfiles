def custom_repr(enable=True):
    if enable:
        get_ipython().display_formatter.formatters['text/plain'].for_type(str, lambda n, p, cycle: p.text(repr_str(n)))
        get_ipython().display_formatter.formatters['text/plain'].for_type(int, lambda n, p, cycle: p.text(repr_int(n)))
    else:
        get_ipython().display_formatter.formatters['text/plain'].for_type(str, lambda n, p, cycle: p.text(n))
        get_ipython().display_formatter.formatters['text/plain'].for_type(int, lambda n, p, cycle: p.text(n))


def repr_int(x):
    return f"{x} [0x{x:x}]"

def repr_str(s):
    l = len(s)
    return f"{s} [len:{l}]"

custom_repr(True)
