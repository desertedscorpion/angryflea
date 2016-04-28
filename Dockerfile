FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
USER root
RUN dnf update --assumeyes && dnf install --assumeyes git emacs* dbus && dnf update --assumeyes && dnf clean all && dbus-uuidgen > /var/lib/dbus/machine-id
USER ${LUSER}
ENV GIT_HOST="github.com"
VOLUME /var/private
RUN mkdir /home/${LUSER}/.ssh && chmod 0700 /home/${LUSER}/.ssh
CMD echo -e "Host ${GIT_HOST}\nIdentityFile\n/home/${LUSER}/.ssh/id_rsa\nStrictHostKeyChecking no" > /home/${LUSER}/.ssh/config && chmod 0600 /home/${LUSER}/.ssh/config && cp /var/private/id_rsa /home/${LUSER}/id_rsa && chmod 0600 /home/${LUSER}/.ssh/id_rsa && mkdir /home/${LUSER}/workspace && git -C /home/${LUSER}/workspace init && git -C remote add origin ${GIT_URL} && git config --global user.email ${GIT_EMAIL} && git config --global user.name ${GIT_NAME} && bash
