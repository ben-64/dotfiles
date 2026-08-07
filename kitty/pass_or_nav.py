# pass_or_nav.py — kitten de routage kitty <-> zellij
#
# Principe : selon qu'on soit dans un pane où tourne zellij ou non, la même
# touche envoie soit une séquence à zellij, soit exécute une action kitty.
#
# Installation :  ~/.config/kitty/pass_or_nav.py
#
# Usage kitty :  map <touche> kitten pass_or_nav.py <clef_zellij> <action_kitty> [arg]
#
#   map cmd+left  kitten pass_or_nav.py left  neighboring_window left
#   map cmd+right kitten pass_or_nav.py right neighboring_window right
#   map cmd+up    kitten pass_or_nav.py up    neighboring_window top
#   map cmd+down  kitten pass_or_nav.py down  neighboring_window bottom
#   map cmd+t     kitten pass_or_nav.py tab   new_tab

from kittens.tui.handler import result_handler

# Séquences envoyées à zellij quand il est détecté (\x02 = Ctrl+b = leader).
ZELLIJ_SEQ = {
    'left':  b'\x02\x1b[D',
    'right': b'\x02\x1b[C',
    'up':    b'\x02\x1b[A',
    'down':  b'\x02\x1b[B',
    'tab':   b'\x02t',       # leader + t  -> mode tab de zellij
    'prev_tab': b'\x02t[',    # leader + [  -> tab précédent zellij
    'next_tab': b'\x02t]',    # leader + ]  -> tab suivant zellij
}


def main(args):
    # Tout se passe dans handle_result (accès au boss kitty).
    pass


def _is_zellij(window):
    try:
        procs = window.child.foreground_processes
    except Exception:
        return False
    for p in procs:
        cmdline = p.get('cmdline') or []
        if any('zellij' in part for part in cmdline):
            return True
    return False


# neighboring_window (méthode Python) attend top/bottom, pas up/down.
_DIR_ALIAS = {'up': 'top', 'down': 'bottom'}


def _do_kitty_action(boss, action, arg):
    if action == 'neighboring_window':
        d = arg or 'left'
        boss.active_tab.neighboring_window(_DIR_ALIAS.get(d, d))
    elif action == 'new_tab':
        boss.launch('--type=tab')
    elif action == 'previous_tab':
        boss.previous_tab()
    elif action == 'next_tab':
        boss.next_tab()
    # extensible : ajoute ici d'autres actions kitty au besoin
    #   elif action == 'new_window':
    #       boss.launch('--location=vsplit', '--cwd=current')


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    # args = [script, <clef_zellij>, <action_kitty>, <arg_kitty?>]
    zellij_key = args[1]
    kitty_action = args[2]
    kitty_arg = args[3] if len(args) > 3 else None

    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    if _is_zellij(window):
        seq = ZELLIJ_SEQ.get(zellij_key)
        if seq:
            window.write_to_child(seq)
    else:
        _do_kitty_action(boss, kitty_action, kitty_arg)
