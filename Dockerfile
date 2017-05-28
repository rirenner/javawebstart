FROM openjdk:7


# xorg and sudo is needed to run X as non-root
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y xorg sudo

# run X as non-root
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/dockeruser && \
    echo "dockeruser:x:${uid}:${gid}:Developer,,,:/home/dockeruser:/bin/bash" >> /etc/passwd && \
    echo "dockeruser:x:${uid}:" >> /etc/group && \
    echo "dockeruser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dockeruser && \
    chmod 0440 /etc/sudoers.d/dockeruser && \
    chown ${uid}:${gid} -R /home/dockeruser

USER dockeruser
ENV HOME /home/dockeruser

