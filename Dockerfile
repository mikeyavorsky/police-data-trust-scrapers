# docker build command:
# docker build -t police-data-trust-scraper-dev -f Dockerfile .
FROM python:3-slim-bookworm

RUN apt update -y && apt install curl unzip -y

WORKDIR /app/

ENV PYTHONPATH=/app/:$PYTHONPATH

COPY ./requirements.txt .
RUN pip install -r requirements.txt
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install

COPY . .

WORKDIR /app/scrapers/fifty_a

CMD [ "./run.sh" ]
