#!/bin/bash

# Filenames
MD="${1}"
HTML="${1%.*}.html"
HTEX="${1%.*}.htex"
JSON="${1%.*}.json"

# Location of javascript files
THEME="/root/assets/Template/RS.theme"
CSS="/root/assets/Template/RS.css"
BIBFILE="References.bib"
CSL="/root/assets/ieee.csl"
PDCR=pandoc-crossref

TMP_EQNS="TEMP_svg_eqns"

GLADTEX_ARGS="-a -K -d TEMP_SVG_EQNS -p \\usepackage{bm,newpxtext,newpxmath,amsmath,amssymb,mhchem}\\usepackage[separate-uncertainty=true,group-separator={,}]{siunitx}\\sisetup{mode=text,range-phrase={\\text{~to~}}}"
export GLADTEX_ARGS
echo $GLADTEX_ARGS

YYYYMMDD=$(python -c "from datetime import datetime as dt; n=dt.now(); print(n.strftime('%Y%m%d'))")
DATE=$(python -c "from datetime import datetime as dt; n=dt.now(); print(n.strftime('%d-%b-%Y'))")
HTML="${YYYYMMDDD}-${HTML}"

cmd1="s/{{DATE}}/${DATE}/"
cmd2="s/{{YYYYMMDD}}/${YYYYMMDD}/"
sed -e $cmd1 -e $cmd2 < $MD > $MD_TMP

# Note that I am using my own forked version of GladTex, so that equation SVG images are embedded and not formatted like links
CMD1="pandoc --from markdown+raw_tex --to json --filter pantable --filter /root/assets/filters/comments.py --filter /root/assets/filters/metavars.py --filter pandoc-crossref --filter pandoc-citeproc --strip-comments --listings --csl /root/assets/ieee.csl --filter gladtex --output ${JSON} /root/assets/Template/RS-Template-Report.yaml ${MD_TMP}"
CMD2="pandoc --from json --to html5 --self-contained --standalone --css ${CSS} --highlight-style ${THEME}  --section-divs ${JSON} --output ${HTML}"

echo $CMD1
$CMD1

echo $CMD2
$CMD2


# rm -rf ${TMP_EQNS}
# gladtex -K -a -R -p "\usepackage{bm} \usepackage{newpxtext,newpxmath,amsmath,amssymb,mhchem} \usepackage[separate-uncertainty=true, group-separator={,}]{siunitx} \sisetup{mode=text, range-phrase = {\text{~to~}}}" -d ${TMP_EQNS} -o ${HTML} ${HTEX}
# open -a "Firefox.app" ${HTML}
# rm ${HTEX}
# rm -rf ${TMP_EQNS}
