FROM pandoc/latex:edge
RUN pip3 install pandocfilters
WORKDIR /root
ADD assets.tar ./
RUN mkdir bin && export PATH=/root/bin:${PATH}
COPY pandoc_report.sh /root/bin/
RUN chmod 700 /root/bin/pandoc_report.sh

# For testing only
CMD [ "/bin/bash" ]
WORKDIR /data
# ENTRYPOINT ["docker-entrypoint.sh"]