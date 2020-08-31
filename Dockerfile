FROM python:3

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt install -fy \
      tzdata \
      bash curl wget ncat iperf3 mc htop git tmux vim bash-completion \
      clamav clamav-daemon \
      dnsutils net-tools && \
    pip install requests pytest pyyaml xmltodict dicttoxml cvsslib dnspython packaging && \
    curl -L get.docker.io | bash && \
    apt-get -y purge docker-ce containerd.io && \
    curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-Linux-x86_64" -o /usr/bin/docker-compose && \
    curl -L "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64" -o /usr/bin/gitlab-runner && \
    curl -L "https://storage.googleapis.com/kubernetes-release/release/v1.18.4/bin/linux/amd64/kubectl" -o /usr/bin/kubectl && \
    chmod +x /usr/bin/docker-compose /usr/bin/gitlab-runner /usr/bin/kubectl && \
    curl -L "https://raw.githubusercontent.com/aquasecurity/trivy/master/contrib/install.sh" | sh -s -- -b /usr/local/bin && \
    ln -s /usr/local/bin/trivy /usr/bin/trivy && \
    curl -L "https://get.helm.sh/helm-v3.3.0-linux-amd64.tar.gz" | tar -xzvf - && \
    mv -f linux-amd64/helm /usr/bin/helm3 && rm -rf linux-amd64 && \
    curl -L "https://get.helm.sh/helm-v2.16.10-linux-amd64.tar.gz" | tar -xzvf - && \
    mv -f linux-amd64/tiller /usr/bin/tiller2 && \
    mv -f linux-amd64/helm /usr/bin/helm2 && rm -rf linux-amd64 && \
    chmod +x /usr/bin/helm2 /usr/bin/helm3 /usr/bin/tiller2 && \
    rm -rf /var/lib/apt/lists/*
