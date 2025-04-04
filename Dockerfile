
FROM python:3.10-slim

# Install system dependencies (ffmpeg ist notwendig für MP4)
RUN apt-get update && \
    apt-get install -y ffmpeg git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Whisper von OpenAI
RUN pip install git+https://github.com/openai/whisper.git

# Optional (empfohlen): Installiere FastAPI und Uvicorn für eine einfache API-Schnittstelle
RUN pip install fastapi uvicorn python-multipart

# Erstelle Arbeitsverzeichnis
WORKDIR /app

# Kopiere API-Datei (server.py muss von dir noch hinzugefügt werden)
COPY server.py /app/server.py

# Port
EXPOSE 8080

# Starte die API
CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8080"]
