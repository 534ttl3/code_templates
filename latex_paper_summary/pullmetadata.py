#!/usr/bin/python3

import sys
import re
import subprocess
from pathlib import PurePath


def pullmetadata(filepath):
    cmd = ['pdfinfo', sys.argv[1]]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
    out, err = proc.communicate()
    retcode = proc.returncode  # success/failure
    if not retcode == 0:
        raise ValueError('Error {} executing command: {}'.format(
            retcode, ' '.join(cmd)))
    out_str = out.decode("utf-8")

    # find fields in pdfinfo output
    pattern = re.compile(r"Title\:\s*([^\n]+)")
    title = pattern.findall(out_str)
    pattern = re.compile(r"Subject\:\s*([^\n]+)")
    subject = pattern.findall(out_str)
    pattern = re.compile(r"Author\:\s*([^\n]+)")
    author = pattern.findall(out_str)

    return {"Title": title[0], "Subject": subject[0], "Author": author[0]}


def substituteinfilewithregex(operateonfilepath, metadata):
    myinput = open(operateonfilepath).read()  # doesnt leave a handler behind, 
    # so it should be directly closing the read stream 
    # (myinput is just a string)

    # myoutput = open("output.tex", "w")  # debugging
    myoutput = open(operateonfilepath, "w")
    myinput_modified = re.sub(
        r'\\mysummarytitle\{.*\}', r'\mysummarytitle{' + metadata["Title"] + '}', myinput, flags=re.M)
    myinput_modified = re.sub(
        r'\\mysummaryPaperOriginalAuthors\{.*\}', r'\mysummaryPaperOriginalAuthors{' + metadata["Author"] + '}', myinput_modified, flags=re.M)
    myinput_modified = re.sub(
        r'\\mysummaryPaperSubject\{.*\}', r'\mysummaryPaperSubject{' + metadata["Subject"] + '}', myinput_modified, flags=re.M)

    myoutput.write(myinput_modified)
    myoutput.close()


def main():
    if len(sys.argv) != 2:
        print("Usage: python pullmetadata.py pdf_filename")

    metadata = pullmetadata(sys.argv[1])

    substituteinfilewithregex(
        str(
            PurePath(sys.argv[1]).parent /
            PurePath(
                str(
                    PurePath(sys.argv[1]).parts[-1] + "_summary"
                )
            ) / PurePath("main.tex")
        ),
        metadata)

    exit(0)


main()

