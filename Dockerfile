FROM centos/python-35-centos7
MAINTAINER Honza Horak <hhorak@redhat.com>

ADD app /opt/app-root/src

RUN pip install -r requirements.txt


EXPOSE 8080

CMD [ "python", "/opt/app-root/src/app.py" ]


