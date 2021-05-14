#!/usr/bin/env python
# -*- coding: utf-8 -*-

def pkit():
    """ Load PKIT """
    import sys
    sys.path.append("/home/ben64/Documents/eads/pki_phase2/pkit"),
    import scapy
    from scapy.config import conf
    conf.color_theme = scapy.config.themes.DefaultTheme()
    mod = __import__('pkit.all',globals(),locals())
    for k,v in mod.__dict__.iteritems():
        globals()[k]=v
