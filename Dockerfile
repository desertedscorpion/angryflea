FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
USER root
RUN dnf update --assumeyes && dnf install --assumeyes git bash-completion emacs* dbus && dnf update --assumeyes && dnf clean all && dbus-uuidgen > /var/lib/dbus/machine-id
COPY post-commit.sh /usr/local/bin/post-commit
RUN chmod 0555 /usr/local/bin/post-commit
USER ${LUSER}
VOLUME /var/private
RUN mkdir /home/${LUSER}/.ssh && chmod 0700 /home/${LUSER}/.ssh && mkdir /home/${LUSER}/workspace
WORKDIR /home/${LUSER}/workspace
CMD echo -e "Host ${GIT_HOST}\nIdentityFile /home/${LUSER}/.ssh/id_rsa\nStrictHostKeyChecking no" > /home/${LUSER}/.ssh/config && chmod 0600 /home/${LUSER}/.ssh/config && cp /var/private/id_rsa /home/${LUSER}/.ssh/id_rsa && chmod 0600 /home/${LUSER}/.ssh/id_rsa && git -C /home/${LUSER}/workspace init && git -C /home/${LUSER}/workspace remote add origin ${GIT_URL} && git config --global user.email "${GIT_EMAIL}" && git config --global user.name "${GIT_NAME}" && ln --symbolic --force /usr/local/bin/post-commit /home/${LUSER}/workspace/.git/hooks && bash
