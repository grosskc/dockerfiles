#! /usr/bin/env python

"""
Pandoc filter to convert pdf to svg
"""

__author__ = "Kevin Gross"

import mimetypes
import subprocess
import os
import sys
import urllib
import re
from pandocfilters import toJSONFilter, Str, Para, Image

def pdf_to_svg(key, value, fmt, meta):
    if key == 'Image':
        print(value)
        attrs, alt, [fn_pdf, title] = value
        try:
            mimet, _ = mimetypes.guess_type(fn_pdf)
            if (mimet == 'application/pdf'):
                fn_pdf = os.path.realpath(fn_pdf)
                base_name, _ = os.path.splitext(fn_pdf)
                fn_svg = base_name + ".svg"
                print(f"In: {fn_pdf}; Out: {fn_svg}")
                try:
                    mtime = os.path.getmtime(fn_svg)
                except OSError:
                    mtime = -1
                if mtime < os.path.getmtime(fn_pdf):
                    cmd_line = ['dvisvgm', '--stdout', '--pdf', fn_pdf, ">", fn_svg]
                    print("Running %s\n" % " ".join(cmd_line))
                    out = subprocess.call(cmd_line)
                    retVal = Image(attrs, alt, [fn_svg, title])
                    print(retVal)
                    return retVal
        except:
            return Image(attrs, alt, [fn_pdf, title])


if __name__ == "__main__":
    toJSONFilter(pdf_to_svg)
