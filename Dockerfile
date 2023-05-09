FROM python:3.8.10-slim-buster
WORKDIR /app
COPY . /app
RUN pip3 install flask flask-SQLAlchemy
CMD ["python3","app.py"]
