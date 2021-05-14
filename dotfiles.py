#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import argparse
import os
import glob
import shutil

prefix = "."
home = os.path.expanduser("~")

def parse_args():
    parser = argparse.ArgumentParser(description="Handle your dotfiles")
    parser.add_argument("-a","--add",metavar="FILES",nargs="*",help="Files that we need")
    parser.add_argument("-c","--check",action="store_true",help="Check wich files are not handled by the dotfiles")
    parser.add_argument("-l","--list",action="store_true",help="List synchronized files")
    parser.add_argument("-r","--repo",metavar="FOLDER",default=os.path.dirname(os.path.realpath(__file__)),help="Folders where are the configuration files")
    parser.add_argument("--force",action="store_true",help="Do not ask for modification")
    return parser.parse_args()

def main():
    args = parse_args()

    try:
        ignore_files = open(os.path.join(args.repo,"dotfilesignore"),"r").read().split("\n")
    except IOError:
        ignore_files = []

    if args.add:
        for f in args.add:
            dst = os.path.join(home,prefix+f)
            if os.path.exists(dst):
                ans = "y" if args.force else input("File %s exists, overwrite (y/N) ? " % dst)
                if ans == "y":
                    if os.path.isdir(dst) and not os.path.islink(dst):
                        shutil.rmtree(dst)
                    else:
                        os.unlink(dst)
                else:
                    continue
            os.symlink(os.path.abspath(os.path.join(args.repo,f)),dst)
    elif args.check:
        for f in sorted(glob.glob(os.path.join(args.repo,"*"))):
            f = os.path.basename(f)
            if not f in ignore_files:
                if not os.path.exists(os.path.join(home,prefix+f)):
                    print("Missing %s" % (f,))
                elif os.path.realpath(os.path.join(home,prefix+f)) != os.path.abspath(os.path.join(args.repo,f)):
                    print("Different %s" % (f,))
    elif args.list:
        for f in sorted(glob.glob(os.path.join(args.repo,"*"))):
            f = os.path.basename(f)
            if os.path.exists(os.path.join(home,prefix+f)) and os.path.realpath(os.path.join(home,prefix+f)) == os.path.abspath(os.path.join(args.repo,f)):
                print("%s" % (f,))

    return 0

if __name__ == "__main__":
   sys.exit(main())
