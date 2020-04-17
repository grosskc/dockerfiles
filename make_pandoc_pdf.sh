#!/bin/bash
MD="${1}"

# DEBUG
# docker run --rm --volume "`pwd`:/data" -it rs/pandoc:latest

PANDOC="docker run --rm --volume "`pwd`:/data" rs/pandoc:latest /root/bin/pandoc_report.sh "

echo "This is the command being sent to Docker"
echo ${PANDOC} ${MD}
echo " "

echo "This is the command being run within Docker"
${PANDOC} ${MD}
