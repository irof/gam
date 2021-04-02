FROM alpine:3.13.3

RUN apk update && apk upgrade \
  && apk --no-cache add graphviz fontconfig \
  && cd /home \
  && wget https://moji.or.jp/wp-content/ipafont/IPAfont/ipag00303.zip \
  && unzip ipag00303.zip \
  && mkdir -p /usr/share/fonts/ipa \
  && cp ipag00303/ipag.ttf /usr/share/fonts/ipa \
  && rm -rf ipag00303.zip ipag00303 \
  && fc-cache -fv

