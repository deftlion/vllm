#!/bin/bash

python_executable=python$1
pytorch_version=$2
cuda_version=$3

# Install torch
$python_executable -m pip install numpy pyyaml scipy ipython mkl mkl-include ninja cython typing pandas typing-extensions dataclasses setuptools && conda clean -ya

if [[ $pytorch_version == "nightly" ]]; then
  $python_executable -m pip install torch --pre --upgrade --index-url https://download.pytorch.org/whl/nightly/cu121
else
  $python_executable -m pip install torch==${pytorch_version}+cu${cuda_version//./} --extra-index-url https://download.pytorch.org/whl/cu${cuda_version//./}
fi
# Print version information
$python_executable --version
$python_executable -c "import torch; print('PyTorch:', torch.__version__)"
$python_executable -c "import torch; print('CUDA:', torch.version.cuda)"
$python_executable -c "from torch.utils import cpp_extension; print (cpp_extension.CUDA_HOME)"
