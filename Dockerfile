FROM python:3.12-slim-bookworm
RUN apt-get update && apt-get upgrade -y
WORKDIR /app

COPY app ./app

EXPOSE 8000

CMD ["python", "app/app.py"]
