#!/usr/bin/python3

import sys
import os
import subprocess
from pathlib import PurePath

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 createSummaryForPDF.py target_paper_pdf_filepath")

    script_path = os.path.dirname(os.path.abspath(__file__))
    pdf_abspath = os.path.abspath(sys.argv[1])

    # first populate folder structure
    cmd = [str(PurePath(script_path) / PurePath("populatefs.py")), pdf_abspath]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
    out, err = proc.communicate()
    retcode = proc.returncode  # success/failure
    if not retcode == 0:
        raise ValueError('Error {} executing command: {}'.format(
            retcode, ' '.join(cmd)))

    # then pull in metadata
    cmd = [str(PurePath(script_path) / PurePath("pullmetadata.py")), pdf_abspath]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
    out, err = proc.communicate()
    retcode = proc.returncode  # success/failure
    if not retcode == 0:
        raise ValueError('Error {} executing command: {}'.format(
            retcode, ' '.join(cmd)))

    exit(0)


main()
