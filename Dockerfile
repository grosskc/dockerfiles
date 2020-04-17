FROM pandoc/latex:edge
RUN pip3 install pandocfilters
RUN tlmgr install preview

RUN rm -rf GladTeX
RUN git clone https://github.com/grosskc/GladTeX.git
RUN cd GladTeX && python3 setup.py install && cd .. && rm -rf GladTeX
RUN apk add --no-cache ipython

WORKDIR /root
ADD assets.tar ./
RUN mkdir bin && export PATH=/root/bin:${PATH}
COPY pandoc_*.sh /root/bin/
RUN chmod 700 /root/bin/pandoc_*.sh

# For testing only
CMD [ "/bin/bash" ]
WORKDIR /data
