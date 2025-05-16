# sfapi training NERSC May 2025

## sfapi_client demo

The source code for the client is available on the NERSC github page at [github.com/NERSC/sfapi_client](https://github.com/NERSC/sfapi_client).
It's easily added to a project from the repository on PyPi and installable with pip.

```shell
pip install sfapi_client
```

For running the demos locally you can create a virtual environment and install the dependencies.

```shell
python -m venv .venv
source .venv/bin/activate
pip install -e .
jupyter-notebook
```

Or if you use [uv](https://docs.astral.sh/uv)...

```shell
uv sync
source .venv/bin/activate
jupyter-notebook
```

For the training we'll be writing code in the [sfapi_client_demo](sfapi_client_demo.ipynb) notebook.
If you want to see the pre-written code and follow along there, you can open the [sfapi_client_demo](sfapi_client_demo_completed.ipynb).
