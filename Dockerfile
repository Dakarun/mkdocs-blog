FROM python:3.10

WORKDIR /opt

#RUN apt update && \
#    add-apt-repository ppa:deadsnakes/ppa && \
#    apt install -y curl python3.10
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN git clone https://github.com/Dakarun/mkdocs-blog.git

ENV PATH="/root/.local/bin:$PATH"
WORKDIR /opt/mkdocs-blog
RUN POETRY_VIRTUALENVS_CREATE=false poetry install --no-root --only main --no-interaction --no-ansi
RUN mkdocs -V

EXPOSE 8000
CMD mkdocs serve -a 0.0.0.0:8000