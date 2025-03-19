FROM thevlang/vlang:debian-dev AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN --mount=type=cache,target=/root/.vmodules \
    v -prod -v -o /bin/server .

FROM debian:trixie-slim AS final

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash -u 1000 appuser

COPY --from=builder /bin/server /usr/local/bin/server

RUN chown appuser:appuser /usr/local/bin/server && \
    chmod 500 /usr/local/bin/server

USER appuser

ENTRYPOINT ["/usr/local/bin/server"]
