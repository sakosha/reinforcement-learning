FROM python:3.11-slim

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8888

ENV JUPYTER_ALLOW_INSECURE_WRITES=true

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--port", "8888", "--no-browser", "--allow-root", "--notebook-dir=/app/notebooks"]

# docker build -t jupyterlab-image .
# docker run -p 127.0.0.1:8888:8888 -v $(pwd)/notebooks:/app/notebooks jupyterlab-image