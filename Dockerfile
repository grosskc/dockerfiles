FROM pandoc/latex:edge
RUN pip3 install pandocfilters
RUN tlmgr install preview

RUN rm -rf GladTeX
RUN git clone https://github.com/grosskc/GladTeX.git
RUN cd GladTeX && python3 setup.py install && cd .. && rm -rf GladTeX
RUN apk add --no-cache ipython

RUN tlmgr install tcolorbox environ trimspaces
RUN pip3 install pandoc-latex-admonition pandoc-include

WORKDIR /root
ADD assets.tar ./
RUN mkdir bin && export PATH=/root/bin:${PATH}
COPY pandoc_*.sh /root/bin/
RUN chmod 700 /root/bin/pandoc_*.sh
ENV PATH "/root/bin:$PATH"
RUN echo "export PATH=/new/path:${PATH}" >> /root/.bashrc

# For testing only
CMD [ "/bin/bash" ]
WORKDIR /data
