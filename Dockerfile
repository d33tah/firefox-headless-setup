FROM centos:7 as base
RUN yum install -y firefox epel-release
RUN dbus-uuidgen > /var/lib/dbus/machine-id
RUN curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest \
  | grep browser_download_url \
  | grep linux64 \
  | cut -d '"' -f 4 \
  | xargs curl -L | tar -zxvf - -C /usr/bin

ENV MOZ_HEADLESS=1

FROM base as test

RUN yum install -y python34 python34-setuptools
RUN python3 -m easy_install pip
ADD ./requirements.txt .
RUN python3 -m pip install -r requirements.txt

ADD browser_test browser_test
ADD manage.py .
RUN python3 ./manage.py test

FROM base
