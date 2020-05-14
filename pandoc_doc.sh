#!/bin/bash

# docker run --rm --volume "`pwd`:/data" -it rs/pandoc

MD="${1}"
PDF="${MD%.*}.docx"
MD_TMP=".${MD}"

YYYYMMDD=$(python -c "from datetime import datetime as dt; n=dt.now(); print(n.strftime('%Y%m%d'))")
DATE=$(python -c "from datetime import datetime as dt; n=dt.now(); print(n.strftime('%d-%b-%Y'))")
PDF="${YYYYMMDD}-${PDF}"
TEX="${YYYYMMDD}-${TEX}"

cmd1="s/{{DATE}}/${DATE}/"
cmd2="s/{{YYYYMMDD}}/${YYYYMMDD}/"
sed -e $cmd1 -e $cmd2 < $MD > $MD_TMP
PANDOC="pandoc"
# PANDOC_ARGS=" --from markdown+raw_tex --default-image-extension=pdf --filter pandoc-include --filter pantable --filter /root/assets/filters/comments.py --filter /root/assets/filters/metavars.py --filter pandoc-crossref --filter pandoc-citeproc  --filter /root/assets/filters/filter_mermaid.py --filter pandoc-latex-admonition --pdf-engine xelatex --standalone --template=/root/assets/Template/RS-Template-Report.tex --strip-comments --listings --csl /root/assets/ieee.csl /root/assets/Template/RS-Template-Report.yaml "
PANDOC_ARGS=" --from markdown+raw_tex --default-image-extension=pdf --filter pandoc-include --filter pantable --filter /root/assets/filters/comments.py --filter /root/assets/filters/metavars.py --filter pandoc-crossref --filter pandoc-citeproc  --filter /root/assets/filters/filter_mermaid.py --filter pandoc-latex-admonition --pdf-engine xelatex --standalone --template=/root/assets/Template/RS-Template-Report.tex --strip-comments --highlight-style /root/assets/Template/syntax.theme --csl /root/assets/ieee.csl /root/assets/Template/RS-Template-Report.yaml --reference-doc=/root/assets/Template/RS-Template-Report.docx "
echo "Creating ${PDF} using the following command:"
echo ${PANDOC} ${PANDOC_ARGS} ${MD} -o ${PDF}
${PANDOC} ${PANDOC_ARGS} ${MD_TMP} -o ${TEX}
${PANDOC} ${PANDOC_ARGS} ${TEX} -o ${PDF} && rm ${MD_TMP}