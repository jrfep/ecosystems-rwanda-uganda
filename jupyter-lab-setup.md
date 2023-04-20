
# Set up working environment

There are several ways to set up the working environment to run the python and R code. 

The documentation for installing the earthengine-api has options for conda and pip:

https://developers.google.com/earth-engine/guides/python_install

I tried both approaches in different machines, here are some notes.

## Option 1: Conda + jupyter-lab + ee

I once installed [conda in my MacBook](https://docs.conda.io/projects/continuumio-conda/en/latest/user-guide/install/macos.html)...

I then created an environment called `ee` with the setup for:
- running jupyter lab
- connecting to earth-engine.

```sh
conda activate
conda create --name ee
conda activate ee
conda install -c conda-forge earthengine-api
conda install psycopg2
conda install folium -c conda-forge
```


Authenticate
```sh
earthengine authenticate
ls $HOME/.config/earthengine/credentials
```




Now I need to install packages required to work with iNaturalist API

```sh
conda activate ee
pip install ipyplot pyinaturalist rich
```

Now I can activate this environment and call jupyter lab, and run the jupyter notebook from that interface:

```sh
conda activate ee
jupyter lab
```

:::note
Remember to keep the client library up to date :

    Conda Package Manager: `conda update -c conda-forge earthengine-api`
    
:::

## Option 2: venv + jupyterlab + ee

In Linux Solus I set up a virtual environment for `earth engine`

```sh
python3 -m venv ~/proyectos/venv/ee
source ~/proyectos/venv/ee/bin/activate
python --version
pip install --upgrade pip
```

Now let's try the same with pip

```sh
pip install earthengine-api
pip install folium 
pip install jupyter
pip install ipykernel
pip install ipyplot pyinaturalist rich
pip install pandas
pip install jupyterlab
```

So I can do the same as before:

```sh
source ~/proyectos/venv/ee/bin/activate
jupyter lab
```

I configured a secure connection so I need to provide a password for access to the jupyter lab and notebooks.

::: note
Remember to keep the client library up to date :

    Python Package Installer: `pip install earthengine-api --upgrade`

:::

## Option 2: venv + visualcode + ee

Now trying to run the jupyter notebook from Visual Studio Code I ran into some problems, I tried to follow these instructions:

https://code.visualstudio.com/docs/datascience/jupyter-notebooks

I also downloaded and enabled the **Python Environment Manager** extension (id: donjayamanne.python-environment-manager).

In settings / python extensions, add `proyectos/env` to locate the folder with the environments

I can select the correct environment for python, but the Jupyter extension is not working properly

I guess there can be a problem with the password configuration that is interrumpting the access to the jupyter server. Still need to figure this out. 

