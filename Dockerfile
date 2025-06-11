FROM registry.access.redhat.com/ubi9/python-312:1-1749108609 as build
# build requirements.txt
USER 0
COPY pyproject.toml uv.lock .
# generate requirements.txt
RUN pip install -U pip && pip install uv
RUN uv sync && uv pip freeze > ./requirements.txt
RUN pip uninstall uv -y

# install deps
USER 1001
RUN pip install -U pip && pip install -r ./requirements.txt
RUN curl -k -o /opt/app-root/src/.cache/huggingface/gradio/frpc/frpc_linux_amd64_v0.3 https://cdn-media.huggingface.co/frpc-gradio-0.3/frpc_linux_amd64

# source code
USER 0
COPY app.py .
RUN chown -R 1001:0 ./
USER 1001

# env vars
# need to pass in MODEL_URL during runtime
EXPOSE 8080
ENV GRADIO_SERVER_NAME=0.0.0.0
ENV GRADIO_SERVER_PORT=8080
ENV GRADIO_NUM_PORTS=1
CMD ["python", "app.py"]
