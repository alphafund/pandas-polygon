#! /bin/bash

apt-get update -y && apt-get install -qq -y \
	htop \
	nano \
	wget \
	git \
	curl \
	bzip2 \
	build-essential
	# make \
	# automake \
	# gfortran \
	# g++ \
	# libbz2-dev \
	# libsqlite3-dev \
	# libreadline-dev \
	# zlib1g-dev \
	# libncurses5-dev \
	# libssl-dev \
	# libgdbm-dev \
	# libffi-dev
	# ca-certificates \
	# libglib2.0-0 \
	# libxext6 \ 
	# libsm6 \ # X11 Session Management library
	# libxrender1 # X Rendering Extension client library
apt-get -qq -y autoremove && \
	apt-get autoclean && 
	rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# add conda to root user path
echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh

# install latest miniconda distro
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -bfp /opt/conda
rm Miniconda3-latest-Linux-x86_64.sh
/opt/conda/bin/conda init -q
conda update -n base -q conda

# update conda settings
conda config --system --prepend channels conda-forge && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    conda config --system --set channel_priority strict

# copy sorce code (remote) -todo -replace with local git pull
gcloud compute scp --zone us-west1-b --recurse \
	/Users/bobcolner/QuantClarity/pandas-polygon \
	gcp-id:/remote/path


# setup trinity program
mkdir trinity
cd trinity

# install project code
git clone https://github.com/bobcolner/pandas-polygon
cd pandas-polygon

# install python deps in conda
conda env create -f conda_quant.yaml
# clea up conda files
conda clean --all --yes


# clone git repos
git clone https://github.com/cudamat/cudamat
cd cudamat
pip install --user .

git clone https://github.com/ChongYou/subspace-clustering
sudo apt install liblapack-dev libopenblas-dev
pip install --index-url https://test.pypi.org/simple/ spams
