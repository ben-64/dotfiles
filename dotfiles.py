#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys,getopt;
import os,glob,shutil

prefix = "."

def usage(exit_code=0):
    print "Usage: %s [options]" % sys.argv[0]
    print "\t-h | --help : Affiche l'aide"
    print "\t-a | --add file : Ajoute un lien symbolique pointant sur file"
    print "\t-c | --check : Affiche les fichiers qui n'ont pas de lien symbolique"
    print "\t-l | --list : Liste les fichiers synchronisés"
    print "\t-r | --repo repository : Précise où se trouvent les fichiers de conf (par défaut répertoire courant)"
    sys.exit(exit_code)

def main():
    home = os.path.expanduser("~")
    repo = os.path.dirname(os.path.realpath(__file__))
    files = None
    action = ""

    try:
        opts,args = getopt.getopt(sys.argv[1:], "ha:clr:",["help","add=","check","list","repo="])
    except getopt.GetoptError, err:
        print str(err)
        usage(1)

    for opt,parm in opts:
        if opt in ("-h","--help"):
            usage(0)
        elif opt in ("-a","--add"):
            if args is None: usage(1)
            files = parm.split(" ")
            action = "add"
        elif opt in ("-c","--check"):
            action = "check"
        elif opt in ("-l","--list"):
            action = "list"
        elif opt in ("-r","--repo"):
            if args is None: usage(1)
            repo = args

    try:
        ignore_files = open(os.path.join(repo,"dotfilesignore"),"rb").read().split("\n")
    except IOError:
        ignore_files = []

    if action == "add":
        for f in files:
            dst = os.path.join(home,prefix+f)
            if os.path.exists(dst):
                ans = raw_input("File %s exists, overwrite (y/N) ? " % dst)
                if ans == "y":
                    if os.path.isdir(dst) and not os.path.islink(dst):
                        shutil.rmtree(dst)
                    else:
                        os.unlink(dst)
                else:
                    continue
            os.symlink(os.path.abspath(os.path.join(repo,f)),dst)
    elif action == "check":
        for f in glob.glob(os.path.join(repo,"*")):
            f = os.path.basename(f)
            if not f in ignore_files:
                if not os.path.exists(os.path.join(home,prefix+f)):
                    print "Missing %s" % (f,)
                elif os.path.realpath(os.path.join(home,prefix+f)) != os.path.abspath(os.path.join(repo,f)):
                    print "Different %s" % (f,)
    elif action == "list":
        for f in glob.glob(os.path.join(repo,"*")):
            f = os.path.basename(f)
            #print os.path.realpath(os.path.join(home,prefix+f))
            #print os.path.join(repo,f)
            if os.path.exists(os.path.join(home,prefix+f)) and os.path.realpath(os.path.join(home,prefix+f)) == os.path.abspath(os.path.join(repo,f)):
                print "%s" % (f,)

if __name__ == "__main__":
   main()
