FROM python:3.9-alpine

WORKDIR /usr/src/app

# @todo poetry
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT [ "python" ]
