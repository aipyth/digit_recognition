# { pkgs ? import <nixpkgs> {} }:
#
# pkgs.mkShell {
#   buildInputs = with pkgs; [
#     # Python 3.11 and necessary packages
#     (python311.withPackages (ps: with ps; [
#       ipykernel
#       jupyterlab
#       jupyter
#       notebook
#       pip
#
#       matplotlib
#       numpy
#       tensorflow
#       keras
#       ipython
#       # Add any additional visualization libraries you need here, for example:
#       # seaborn
#       # plotly
#       # pandas
#     ]))
#
#     # System packages (non-Python)
#     git
#     wget
#     # Add any additional system packages you need here
#   ];
#
#   # Set any environment variables you need
#   # For example, to specify the use of Jupyter notebooks with IPython
#   # you can uncomment the following line:
#   # SHELLHOOK = ''
#   # export JUPYTER_PATH="${pkgs.python311Packages.ipython}/share/jupyter";
#   # '';
# }

with import <nixpkgs> { };

let
  pythonPackages = python310Packages; # Change to Python 3.10
in pkgs.mkShell rec {
  name = "impurePythonEnv";
  venvDir = "./.venv";
  buildInputs = [

    pkgs.stdenv.cc.cc.lib

    git-crypt
    # stdenv.cc.cc # jupyter lab needs

    # pythonPackages.python
    pythonPackages.ipykernel
    pythonPackages.jupyterlab
    pythonPackages.pyzmq    # Adding pyzmq explicitly
    pythonPackages.venvShellHook
    pythonPackages.pip
    pythonPackages.numpy
    pythonPackages.pandas
    pythonPackages.requests

    # sometimes you might need something additional like the following - you will get some useful error if it is looking for a binary in the environment.
    taglib
    openssl
    git
    libxml2
    libxslt
    libzip
    zlib

  ];

  # Run this command, only after creating the virtual environment
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    
    python -m ipykernel install --user --name=myenv4 --display-name="myenv4"
    pip install -r requirements.txt
  '';

  # Now we can execute any commands within the virtual environment.
  # This is optional and can be left out to run pip manually.
  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH
  '';
}
