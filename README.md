# Simple Chatbot

This chatbot chats with a vLLM chatbot.
Running the actual chatbot is outside the scope of this readme for now.

Taken from the [vllm docs](https://github.com/vllm-project/vllm/blob/main/examples/gradio_openai_chatbot_webserver.py).

## Building

There are two `Dockerfile`s, one that does a multistage build in order to
eliminate `uv` and the other that uses `uv` but then just uninstalls it when
building. Really is no harm in leaving `uv`, but just removing anything I do not
need from the final image.

## Running

### Locally

#### Setup

```shell
# make sure you have uv installed
uv python pin 3.12
uv sync
```

#### Run

Use local script:

```shell
# update env vars in run-local.sh
./run-local.sh
```

Or use `uv`:

```shell
cp ./openshift/.env.template to ./openshift/.env
# update ./openshift/.env
uv run --env-file ./openshift/.env ./app.py
```

### OpenShift

1. Copy `./openshift/.env.template` to `./openshift/.env`
2. Update values in `./openshift/.env`, something like:

    ```env
    MODEL_URL=https://llm-route-ic-shared-llm.apps.cluster-5crkf.5crkf.sandbox3281.opentlc.com/v1
    # AUTH_TOKEN=some-token-if-necessary
    ```

3. Deploy

    ```shell
    oc new-project chatbot
    oc apply -k ./openshift
    ROUTE="https://$(oc get routes chatbot -n chatbot -o jsonpath='{.spec.host}')"
    oc patch consolelink chatbot --type='merge' -p "{\"spec\":{\"href\":\"$ROUTE\"}}"
    ```

## Docs

1. [Flaticon Icon](https://www.flaticon.com/free-icons/chatbot)
