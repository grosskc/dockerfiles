ARG base_tag="edge"
FROM pandoc/core:${base_tag}

# NOTE: `libsrvg`, pandoc uses `rsvg-convert` for working with svg images.
# NOTE: to maintainers, please keep this listing alphabetical.
RUN apk --no-cache add \
        freetype \
        fontconfig \
        gnupg \
        gzip \
        librsvg \
        perl \
        python3 \
        tar \
        wget \
        xz

# DANGER: this will vary for different distributions, particularly the
# `linuxmusl` suffix.  Alpine linux is a musl libc based distribution, for other
# "more common" distributions, you likely want just `-linux` suffix rather than
# `-linuxmusl` -----------------> vvvvvvvvvvvvvvvv
ENV PATH="/opt/texlive/texdir/bin/x86_64-linuxmusl:${PATH}"
WORKDIR /root

COPY common/latex/texlive.profile /root/texlive.profile
COPY common/latex/install-texlive.sh /root/install-texlive.sh
RUN /root/install-texlive.sh

COPY common/latex/install-tex-packages.sh /root/install-tex-packages.sh
RUN /root/install-tex-packages.sh
COPY common/latex/install-tex-packages-kcg.sh /root/install-tex-packages-kcg.sh
RUN chmod 700 /root/install-tex-packages-kcg.sh && /root/install-tex-packages-kcg.sh
RUN rm -f /root/texlive.profile \
          /root/install-texlive.sh \
          /root/install-tex-packages.sh
RUN apk --no-cache add ghostscript
WORKDIR /data

# For testing only
RUN apk --no-cache add bash
RUN ln -s /usr/bin/python3 /usr/bin/python
CMD [ "/bin/bash" ]