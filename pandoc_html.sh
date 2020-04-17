#!/bin/bash

# docker run --rm --volume "`pwd`:/data" -it rs/pandoc

# Filenames
MD="${1}"
MD_TMP=".${MD}"
HTML="${MD%.*}.html"
JSON="${MD%.*}.json"

# Location of javascript files
THEME="/root/assets/Template/RS.theme"
CSS="/root/assets/Template/RS.css"
CSL="/root/assets/ieee.csl"

TMP_EQNS=".svg_eqns"

GLADTEX_ARGS="-a -K -d ${TMP_EQNS} -p \\usepackage{bm,newpxtext,newpxmath,amsmath,amssymb,mhchem}\\usepackage[separate-uncertainty=true,group-separator={,}]{siunitx}\\sisetup{mode=text,range-phrase={\\text{~to~}}}"
export GLADTEX_ARGS

YYYYMMDD=$(python -c "from datetime import datetime as dt; n=dt.now(); print(n.strftime('%Y%m%d'))")
DATE=$(python -c "from datetime import datetime as dt; n=dt.now(); print(n.strftime('%d-%b-%Y'))")
HTML="${YYYYMMDD}-${HTML}"

cmd1="s/{{DATE}}/${DATE}/"
cmd2="s/{{YYYYMMDD}}/${YYYYMMDD}/"
sed -e $cmd1 -e $cmd2 < $MD > $MD_TMP

# Note that I am using my own forked version of GladTex, so that equation SVG images are embedded and not formatted like links
CMD1="pandoc --from markdown+raw_tex --to json --filter /root/assets/filters/filter_mermaid.py --filter pantable --filter /root/assets/filters/comments.py --filter /root/assets/filters/metavars.py --filter pandoc-crossref --filter pandoc-citeproc --strip-comments --listings --csl /root/assets/ieee.csl --filter /root/assets/filters/pdf_to_svg.py --filter gladtex --output ${JSON} /root/assets/Template/RS-Template-Report.yaml ${MD_TMP}"

CMD2="pandoc --from json --to html5 --self-contained --standalone --css ${CSS} --highlight-style ${THEME}  --section-divs --template=/root/assets/Template/RS-default.html ${JSON} --output ${HTML}"

echo $CMD1
$CMD1

echo $CMD2
$CMD2

rm -rf ${TMP_EQNS} ${MD_TMP} ${JSON}
