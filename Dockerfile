# Многостадийная сборка для уменьшения размера
FROM gcc:latest as builder

WORKDIR /app
COPY app.cpp .
RUN g++ -o myapp app.cpp

# Финальный образ
FROM ubuntu:20.04
WORKDIR /app
COPY --from=builder /app/myapp .

# Установка только необходимых зависимостей
RUN apt-get update && \
    apt-get install -y --no-install-recommends libstdc++6 && \
    rm -rf /var/lib/apt/lists/*

CMD ["./myapp"]
