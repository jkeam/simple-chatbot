# Simple Chatbot

This chatbot chats with a vLLM chatbot.
Running the actual chatbot is outside the scope of this readme for now.

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

### OpenShift

1. Copy `./openshift/.env.template` to `./openshift/.env`
2. Update values in `./openshift/.env`, something like:

    ```env
    MODEL_URL=https://llm-route-ic-shared-llm.apps.cluster-5crkf.5crkf.sandbox3281.opentlc.com/v1
    ```

3. Deploy

    ```shell
    oc new-project chatbot
    oc apply -k ./openshift
    ROUTE="https://$(oc get routes chatbot -n chatbot -o jsonpath='{.spec.host}')"
    oc patch consolelink chatbot --type='merge' -p '{"spec":{"href":"$ROUTE"}}'
    ```

## Docs

1. [Flaticon Icon](https://www.flaticon.com/free-icons/chatbot)
