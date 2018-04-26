#!/bin/bash

# Preconfigured variables
OS=debian
User=$(id -un)
Group=$(id -gn)
Origin=$(pwd)
NineSixBoardsLib_Loc=$Origin/96Boards
SphinxLib_Loc=$Origin/cmuSphinx

mkdir $NineSixBoardsLib_Loc
mkdir $SphinxLib_Loc


echo ""
echo ""
echo "==============================="
echo "*******************************"
echo " *** STARTING INSTALLATION ***"
echo "  ** this may take a while **"
echo "   *************************"
echo "   ========================="
echo ""
echo ""

#-------------------------------------------------------
# add library path
#-------------------------------------------------------
echo "export LD_LIBRARY_PATH=/usr/local/lib" | tee -a ~/.bashrc
echo "export VLC_PLUGIN_PATH=/usr/local/lib/pkgconfig" | tee -a ~/.bashrc
source ~/.bashrc

# Install dependencies
echo "========== Update Aptitude ==========="
sudo apt-get update
sudo apt-get upgrade -yq

echo "========== Installing python3 ==========="
sudo apt-get install -y python3 python3-dev python-dev python3-venv 
sudo apt-get upgrade python3
sudo apt-get install -y autoconf build-essential libtool libtool-bin pkg-config automake libpcre3-dev

#sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
#sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 2
#sudo update-alternatives --config python

echo "========== Installing Libraries ==========="
sudo apt-get install -y nano vim
sudo apt-get install -y bison libasound2-dev swig
sudo ldconfig

echo "=================================================="
echo "=================================================="
echo "========== Getting the code for libsoc ==========="
echo "=================================================="
echo "=================================================="

cd $NineSixBoardsLib_Loc
git clone https://github.com/jackmitch/libsoc.git
cd libsoc
autoreconf -i
./configure --enable-python=3 --enable-board="dragonboard410c"
make
sudo make install
sudo ldconfig

echo "========================================================"
echo "========================================================"
echo "========== Getting the code for 96BoardsGPIO ==========="
echo "========================================================"
echo "========================================================"
cd $NineSixBoardsLib_Loc
git clone https://github.com/roykang75/96BoardsGPIO.git
cd 96BoardsGPIO
./autogen.sh
./configure
make
sudo make install
sudo ldconfig

echo "========== Getting the code for cmuSphinxbase ==========="
cd $SphinxLib_Loc
git clone https://github.com/roykang75/sphinxbase.git
cd sphinxbase
./autogen.sh
#./configure --enable-fixed
./configure --enable-fixed --without-lapack
make
sudo make install

echo "========== Getting the code for cmuPocketSphin AiVA DB410c ==========="
cd $SphinxLib_Loc
git clone https://github.com/roykang75/pocketsphinx-AiVA-DB410c.git

cd pocketsphinx-AiVA-DB410c
mkdir extlib
cp ../../96Boards/96BoardsGPIO/lib/.libs/lib96BoardsGPIO.la ./extlib
cp ../../96Boards/96BoardsGPIO/lib/.libs/lib96BoardsGPIO.so ./extlib

cp ../../96Boards/libsoc/lib/.libs/libsoc.la ./extlib
cp ../../96Boards/libsoc/lib/.libs/libsoc.so ./extlib

./autogen.sh
./configure
make
sudo make install

cd $Origin


echo "Install package dependencies"
python3 -m venv env
env/bin/python -m pip install --upgrade pip setuptools
source env/bin/activate


sudo apt-get install -y portaudio19-dev libffi-dev libssl-dev
python -m pip install --upgrade google-auth-oauthlib[tool]

echo "progress oAuth"
google-oauthlib-tool --client-secrets ./client_secret_8624439277-crrm3499kcui4pkr7pgccda5pjc985a7.apps.googleusercontent.com.json --scope https://www.googleapis.com/auth/assistant-sdk-prototype --save --headless


echo "Install gRPC and download Google Assistant"
python -m pip install grpcio grpcio-tools
python -m pip install --upgrade google-assistant-sdk[samples]

echo "regist device model"
googlesamples-assistant-devicetool register-model --manufacturer "Assistant SDK developer" --product-name "Assistant SDK light" --type LIGHT --model roy-model
googlesamples-assistant-devicetool list --model
git clone https://github.com/googlesamples/assistant-sdk-python
cp -r assistant-sdk-python/google-assistant-sdk/googlesamples/assistant/grpc new-project

chmod +x *.sh

echo ""
echo '============================='
echo '*****************************'
echo '========= Finished =========='
echo '*****************************'
echo '============================='
echo ""

#cd new-project
#echo "run Google Assistant"
#python -m pushtotalk --device-model-id roy-model --project-id lofty-ivy-192309
