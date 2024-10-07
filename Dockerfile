FROM registry.access.redhat.com/ubi9/python-312:1-25.1726664318

# deps
USER 1001
COPY requirements.txt .
RUN pip install -U pip && pip install -r requirements.txt

# source code
USER 0
COPY app.py .
RUN chown -R 1001:0 ./
USER 1001

# env vars
# need to pass in MODEL_URL during runtime
EXPOSE 8080
ENV GRADIO_SERVER_NAME="0.0.0.0"

CMD ["python", "app.py"]
