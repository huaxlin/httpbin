FROM huaxlin/ubuntu:22.04-CN

LABEL maintainer="huaxlin <featureoverload@gmail.com>"

RUN apt install python3-pip -y

ARG PyPI_HOST=pypi.tuna.tsinghua.edu.cn
ARG PyPI_REPO=https://${PyPI_HOST}/simple
RUN echo "[global]" > /etc/pip.conf \
 && echo "timeout = 120" >> /etc/pip.conf \
 && echo "index-url = ${PyPI_REPO}" >> /etc/pip.conf \
 && echo "trusted-host = ${PyPI_HOST}" >> /etc/pip.conf


LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."
LABEL org.kennethreitz.vendor="Kenneth Reitz"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
EXPOSE 80

ADD . /httpbin

RUN pip3 install --no-cache-dir "gunicorn~=20.1.0" \
 && pip3 install --no-cache-dir -r /httpbin/requirements.txt
RUN pip3 install --no-cache-dir /httpbin

CMD ["gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]
