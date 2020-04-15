#!/bin/bash
MD="${1}"
MD_TMP=".tmp-${MD}"
PDF="${1%.*}.pdf"
TEX="${1%.*}.tex"
# YAML="${1%.*}.yaml"
# YAML_TMP=".tmp-${YAML}"
DATE=`date '+%Y%m%d'`
YYYYMMDDD=`date '+%Y%m%d'`
PDF="${YYYYMMDDD}-${PDF}"
TEX="${YYYYMMDDD}-${TEX}"

YYYYMMDD=$(python -c "from datetime import datetime as dt; n=dt.now(); print(n.strftime('%Y%m%d'))")
DATE=$(python -c "from datetime import datetime as dt; n=dt.now(); print(n.strftime('%d-%b-%Y'))")
cmd1="s/{{DATE}}/${DATE}/"
cmd2="s/{{YYYYMMDD}}/${YYYYMMDD}/"
sed -e $cmd1 -e $cmd2 < $MD > $MD_TMP
PANDOC="pandoc"
PANDOC_ARGS=" --from markdown+raw_tex --filter pantable --filter /root/assets/filters/comments.py --filter /root/assets/filters/metavars.py --filter pandoc-crossref --filter pandoc-citeproc  --filter /root/assets/filters/filter_mermaid.py --pdf-engine xelatex --standalone --template=/root/assets/Template/RS-Template-Report.tex --strip-comments --listings --csl /root/assets/ieee.csl /root/assets/Template/RS-Template-Report.yaml "
# --include-in-header assets/Template/RS-Template-Report.tex
echo "Creating ${PDF} using the following command:"
echo ${PANDOC} ${PANDOC_ARGS} ${MD} -o ${PDF}
${PANDOC} ${PANDOC_ARGS} ${MD_TMP} -o ${TEX}
${PANDOC} ${PANDOC_ARGS} ${MD_TMP} -o ${PDF}
