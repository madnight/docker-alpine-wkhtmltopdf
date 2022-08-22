FROM alpine:3.13
MAINTAINER Fabian Beuke <mail@beuke.org>

RUN apk add --update --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family

# On alpine static compiled patched qt headless wkhtmltopdf (46.8 MB).
COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10-2894863267 \
    /bin/wkhtmltopdf /bin/wkhtmltopdf
RUN [ "$(sha256sum /bin/wkhtmltopdf | awk '{ print $1 }')" \
        == "ed527095e2232bf6f48c5686fc639b19060e6821f220ed8d662d1f57dd0135e9" ]

ENTRYPOINT ["wkhtmltopdf"]
