FROM python:3.11-slim

ENV JUPYTER_ALLOW_INSECURE_WRITES=true
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV USE_POLLING=True

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install uv

WORKDIR /app

COPY requirements.txt /app/

RUN uv pip install --system --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 8888

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--port", "8888", "--no-browser", "--allow-root", "--notebook-dir=/app/notebooks"]

# docker build -t jupyterlab-image .
# docker run -p 127.0.0.1:8888:8888 -v $(pwd)/notebooks:/app/notebooks jupyterlab-image