# sfapi training NERSC May 2025

## sfapi_client demo

The source code for the client is available on the NERSC github page at [github.com/NERSC/sfapi_client](https://github.com/NERSC/sfapi_client).
It's easily added to a project from the repository on PyPi and installable with pip.

```shell
pip install sfapi_client
```

### Running demos on Perlmutter

For running on Perlmutter in jupyter, open a shell, activate the python module, and install the client with `pip`.

```shell
git clone https://github.com/NERSC/sfapi_training.git
module load python
pip install sfapi_client
```

Then open [jupyter.nersc.gov](jupyter.nersc.gov) and navigate to the `sfapi_training/SF-API-Training-NERSC-May-2025` on the left sidebar.

### Running demos on your local machine

For running the demos locally you can create a virtual environment and install the dependencies.

```shell
git clone https://github.com/NERSC/sfapi_training.git
cd sfapi_training/SF-API-Training-NERSC-May-2025
python -m venv .venv
source .venv/bin/activate
pip install -e .
# Start juypter-notebook server or open in an editor that supports ipynb files like vscode
jupyter-notebook
```

Or if you use [uv](https://docs.astral.sh/uv)...

```shell
git clone https://github.com/NERSC/sfapi_training.git
cd sfapi_training/SF-API-Training-NERSC-May-2025
uv sync
source .venv/bin/activate
# Start juypter-notebook server or open in an editor that supports ipynb files like vscode
jupyter-notebook
```

### Following along with the demos

For the training we'll be writing code in the [sfapi_client_demo](sfapi_client_demo.ipynb) notebook.
If you want to see the pre-written code and follow along there, you can open the [sfapi_client_demo_completed](sfapi_client_demo_completed.ipynb).
