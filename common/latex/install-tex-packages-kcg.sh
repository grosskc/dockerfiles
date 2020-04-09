#!/bin/sh
################################################################################
# Stuff for Kevin Gross                                                        #
################################################################################
# eisvogel reqs
tlmgr install adjustbox babel-german background bidi collectbox csquotes everypage filehook footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace pagecolor sourcecodepro sourcesanspro titling ucharcat ulem unicode-math upquote xecjk xurl zref
tlmgr install fontaxes 

# additional useful packages
tlmgr install cabin datatool glossaries mathdesign mfirstuc mhchem newpx newtx siunitx tex-gyre tex-gyre-math xfor
wget https://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
texlua install-getnonfreefonts
getnonfreefonts --sys
tlmgr update --all
tlmgr paper letter
mktexlsr
updmap-sys --force

rm -rf /opt/texlive/texdir/texmf-dist/doc  \
       /opt/texlive/texdir/readme-html.dir \
       /opt/texlive/texdir/readme-txt.dir  \
       /opt/texlive/texdir/install-tl*

# GladTeX
apk --no-cache add git
git clone https://github.com/grosskc/GladTeX.git
cd GladTeX
python3 setup.py install

# panflute
pip3 install git+git://github.com/sergiocorreia/panflute.git
pip3 install git+git://github.com/ickc/pantable.git

# pandoc-crossref
wget https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.2/linux-pandoc_2_9_2.tar.gz && \
    gunzip linux-pandoc_2_9_2.tar.gz && tar -xf linux-pandoc_2_9_2.tar && mv pandoc-crossref /usr/bin/