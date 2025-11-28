FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

# system deps (если нужны)
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# install mlflow + plugin
RUN pip install --no-cache-dir mlflow mlflow-oidc-auth[full] psycopg2-binary boto3

# копируем (опционально) кастомные шаблоны/статические файлы
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 8080
CMD ["/app/entrypoint.sh"]
