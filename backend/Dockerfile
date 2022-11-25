FROM python:3.8
WORKDIR /app/backend

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | POETRY_HOME=/opt/poetry python && \
   cd /usr/local/bin && \
   ln -s /opt/poetry/bin/poetry && \
   poetry config virtualenvs.in-project true


