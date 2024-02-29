FROM ubuntu:latest

LABEL version='1.0' location='Tokyo' type='laptop' role='general development'

SHELL ["/bin/bash", "-c"]

ENV SHELL=/bin/bash

# ubuntuという名前の一般ユーザーを作成
RUN useradd -ms /bin/bash ubuntu

RUN apt update && apt full-upgrade -y && \
  apt install -y sudo vim less zip unzip curl git python3 python3-pip && \
  pip3 install --upgrade pip && \
  pip3 install virtualenv numpy pandas matplotlib seaborn bokeh plotly jupyterlab && \
  passwd -d root && passwd -d ubuntu && \
  usermod -aG sudo ubuntu && \
  echo 'alias python="python3"' >> /home/ubuntu/.bashrc && \ 
  echo 'alias pip="pip3"' >> /home/ubuntu/.bashrc && \
  echo 'alias jupyter="jupyter lab --no-browser --ip=0.0.0.0 --port=8888 --NotebookApp.token=\"\""' >> /home/ubuntu/.bashrc

USER 1000
WORKDIR /home/ubuntu/

# dataディレクトリとnotebookディレクトリをコピーしてボリュームとしてマウント
COPY data /home/ubuntu/data
COPY notebook /home/ubuntu/notebook

# ボリュームとしてマウント
#VOLUME /home/ubuntu/data
#VOLUME /home/ubuntu/notebook

CMD ["jupyter-lab", "--no-browser", "--ip=0.0.0.0", "--port=8888", "--NotebookApp.token=''"]

