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

def svg_to_pdf(key, value, fmt, meta):
    if key == 'Image':
        attrs, alt, [src, title] = value

        mimet, _ = mimetypes.guess_type(src)
        if (mimet == 'application/pdf'):
            base_name, _ = os.path.splitext(src)
            new_name = os.path.realpath(base_name + ".svg")
            src = os.path.realpath(src)
            try:
                mtime = os.path.getmtime(new_name)
            except OSError:
                mtime = -1
            if mtime < os.path.getmtime(src):
                cmd_line = ['dvisvgm --pdf ', src]
                sys.stdout.write("Running %s\n" % " ".join(cmd_line))
                subprocess.call(cmd_line, stdout=sys.stderr.fileno())
            return Image(attrs, alt, [new_name, title])


if __name__ == "__main__":
    toJSONFilter(svg_to_pdf)
