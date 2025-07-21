FROM python:3.8-alpine

RUN apk update && \
    apk --update add libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev curl && \
    apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev git tar

RUN python -m pip install --upgrade pip && \
    pip install kodi-addon-checker

COPY tools/modify_addonxml_matrix.py /modify_addonxml_matrix.py
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]