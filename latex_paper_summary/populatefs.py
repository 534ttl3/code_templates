#!/usr/bin/python3

import subprocess
from pathlib import PurePath

import os
import sys


def main():
    if len(sys.argv) != 2:
        print("Usage: python3 whateverfolder/populatefs.py target_paper_pdf_filepath")

    print("len(sys.argv)", len(sys.argv))
    pdf_abspath = os.path.abspath(sys.argv[1])

    if os.path.exists(pdf_abspath) is False:
        print("ERR:", pdf_abspath, "does not exist!")

    script_path = os.path.dirname(os.path.abspath(__file__))
    fs_dest_path = PurePath(str(PurePath(pdf_abspath)) + "_summary")

    if os.path.exists(str(fs_dest_path)) is True:
        print("WARNING:", pdf_abspath, 
            "already exists and most probably has important data in it!!!")
        
        def yes_or_no(question):
            answer = input(question + "(y/n): ").lower().strip()
            print("")
            while not(answer == "y" or answer == "yes" or
                    answer == "n" or answer == "no"):
                print("Input yes or no")
                answer = input(question + "(y/n):").lower().strip()
                print("")
            if answer[0] == "y":
                return True
            else:
                return False

        if yes_or_no("do you want to re-populate anyway?") is False: 
            print("nothing has been done")
            exit()

    cmd = ["cp", "-r", str(PurePath(script_path) / PurePath("fs")), str(fs_dest_path)]
    proc = subprocess.Popen(cmd)

    exit(0)


main()

