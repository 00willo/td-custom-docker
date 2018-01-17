FROM centos:7
MAINTAINER Graham Williamson <graham@williamsonsinc.id.au>

RUN yum update -y && yum clean all
RUN yum reinstall -y glibc-common
########## OS ##########


########## ENV ##########
# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


RUN yum install -y git gcc gcc-c++ make && yum install -y enchant lapack lapack-devel blas blas-devel python-virtualenvwrapper \
   freetype-devel libpng-devel libxml2-devel libxslt-devel openssl-devel sqlite-devel bzip2-devel readline-devel tk-devel nodejs \
   && yum clean all
RUN yum install -y which && yum clean all
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv && git clone https://github.com/pyenv/pyenv-virtualenv.git /root/.pyenv/plugins/pyenv-virtualenv
RUN echo -e ' \
export PYENV_ROOT="$HOME/.pyenv"\n \
export PATH="$PYENV_ROOT/bin:$PATH"\n \
if command -v pyenv 1>/dev/null 2>&1; then\n \
  eval "$(pyenv init -)"\n \
fi\n \
eval "$(pyenv virtualenv-init -)" \
' >> /root/.bash_profile

ENV HOME  /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install 3.5.3
RUN pyenv global 3.5.3
RUN pyenv rehash

#RUN source /root/.bash_profile && pyenv install 3.5.3 && pyenv global 3.5.3
RUN source /root/.bash_profile && pyenv virtualenv td-py3.5.3
RUN source /root/.bash_profile && pyenv activate td-py3.5.3
RUN python -V
RUN source /root/.bash_profile &&  python -V
RUN echo $PATH
RUN pip install spacy==2.0.3
RUN yum remove -y gcc gcc++
