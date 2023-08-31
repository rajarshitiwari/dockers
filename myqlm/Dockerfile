# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/

ARG PYTHON_VERSION=3.11
FROM dokken/ubuntu-22.04 as base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

# WORKDIR /app

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
ARG UID=10001

RUN useradd -ms /bin/bash wtf

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get -y install curl python3-pip
RUN apt-get install libgomp1

RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python3 -m pip install myqlm jupyter
# python3 -m pip install -r requirements.txt

RUN mkdir -p /home/wtf/.jupyter
COPY jupyter_notebook_config.json /home/wtf/.jupyter/
RUN chown -R wtf /home/wtf

# RUN echo $? "installed"
# Switch to the non-privileged user to run the application.
WORKDIR /home/wtf
# Copy the source code into the container.
COPY . .

USER wtf

ENV PATH=/usr/local/bin:$PATH
# Expose the port that the application listens on.
EXPOSE 8888

# Run the application.
#CMD ["bash"]
CMD jupyter notebook --no-browser --allow-root --ip=0.0.0.0
