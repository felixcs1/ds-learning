import logging

import requests
from fastapi import FastAPI
from fastapi.logger import logger
from fastapi.responses import RedirectResponse
from langserve import add_routes
from starlette.background import BackgroundTasks

from requests.exceptions import ChunkedEncodingError


from chain import chain_simple
from config import OLLAMA_PORT, OLLAMA_URL

gunicorn_logger = logging.getLogger("gunicorn.error")
logger.handlers = gunicorn_logger.handlers
if __name__ != "main":
    logger.setLevel(gunicorn_logger.level)
else:
    logger.setLevel(logging.DEBUG)

app = FastAPI()


# def download_model():
#     print("downloading model")
#     response = requests.post(
#         f"http://{OLLAMA_URL}:{OLLAMA_PORT}/api/pull",
#         json={"model": "orca-mini:3b", "name": "orca-mini:3b"},
#     )
#     try:
#         for data in response.iter_content(chunk_size=1024):
#             print(data)
#     except ChunkedEncodingError as ex:
#         print(f"Invalid chunk encoding {str(ex)}")



# @app.on_event("startup")
# async def startup_event():
#     background_tasks = BackgroundTasks()
#     background_tasks.add_task(download_model)
#     await background_tasks()
#     logger.info("background tasks done")


# http://127.0.0.1:8000/nomic-rag/playground/
# add_routes(app, chain_simple, path="/simple")


@app.get("/")
async def redirect_root_to_docs():
    logger.info("HELLO WORLD!!!")
    return RedirectResponse("/docs")


@app.get("/healthz")
async def healthz():
    logger.info("HELLO WORLD!!!")
    return "Extremely Healthy"


# Edit this to add the chain you want to add
# add_routes(app, NotImplemented)

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=3000)

    #  curl -X POST http://127.0.0.1:11434/api/pull
    # -d '{"model": "orca-mini:3b", "name": "orca-mini:3b"}'
