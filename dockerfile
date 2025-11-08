FROM adguard/adguardhome:latest

RUN apk add --no-cache python3 py3-pip \
    && python3 -m venv /venv \
    && . /venv/bin/activate \
    && pip install bcrypt

ENV PATH="/venv/bin:$PATH"

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
FROM adguard/adguardhome:latest

RUN apk add --no-cache python3 py3-pip \
    && python3 -m venv /venv \
    && . /venv/bin/activate \
    && pip install bcrypt

ENV PATH="/venv/bin:$PATH"

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
