FROM python:3.11-slim AS builder

WORKDIR /build

ENV PIP_NO_CACHE_DIR=1

COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

FROM python:3.11-slim AS runtime

WORKDIR /app

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PATH="/install/bin:${PATH}" \
    PYTHONPATH="/install/lib/python3.11/site-packages"

COPY --from=builder /install /install
COPY app ./app
COPY utils ./utils

RUN useradd --create-home --shell /usr/sbin/nologin appuser \
    && chown -R appuser:appuser /app /install

USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import os, urllib.request; urllib.request.urlopen(f'http://127.0.0.1:{os.environ.get(\"PORT\", \"8000\")}/health', timeout=3).read()"

CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
