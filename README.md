# Simple Chatbot

This chatbot chats with a vLLM chatbot.  Running the actual chatbot is outside the scope of this readme for now.

Taken from the [vllm docs](https://github.com/vllm-project/vllm/blob/main/examples/gradio_openai_chatbot_webserver.py).

## Running

### Locally

#### Setup

```shell
python3.12 -m venv venv
source ./venv/bin/activate
pip install -r ./requirements.txt
```

#### Run

```shell
python ./app.py
```
