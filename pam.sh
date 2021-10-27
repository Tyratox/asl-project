#!/bin/bash

# Install packages

apt-get install libpam-tmpdir libpam-umask

# TODO: 2 Factor Authentication


# Control which users are able to su
# https://www.debian.org/doc/manuals/securing-debian-manual/ch04s11.en.html

# create a new group called 'wheel'
groupadd wheel

# add the root user and the user 'administrator' to it
usermod -a -G wheel root
usermod -a -G wheel administrator

# only allow users of the group wheel to su to root
# TODO: What does 'debug' here stand for?
echo "auth requisite pam_wheel.so group=wheel debug" >> /etc/pam.d/su

# only allow the users listed in /etc/sshusers-allowed to authenticate at a PAM service
echo "auth required pam_listfile.so item=user sense=allow file=/etc/sshusers-allowed onerr=fail" >> /etc/pam.d/su

# then by default create tempfiles separated by users
# see https://wiki.ubuntu.com/SecureTmp for more details (e.g. why optional)

echo "session optional pam_tmpdir.so" >> /etc/pam.d/common-session

# set default umask value
echo "session optional pam_umask.so umask=077" >> /etc/pam.d/common-session

# add secure defaults, i.e. whitelist approach

echo "auth required pam_securetty.so" >> /etc/pam.d/other
echo "auth required pam_unix_auth.so" >> /etc/pam.d/other
echo "auth required pam_warn.so" >> /etc/pam.d/other
echo "auth required pam_deny.so" >> /etc/pam.d/other

echo "account required pam_unix_acct.so" >> /etc/pam.d/other
echo "account required pam_warn.so" >> /etc/pam.d/other
echo "account required pam_deny.so" >> /etc/pam.d/other

echo "password required pam_unix_passwd.so" >> /etc/pam.d/other
echo "password required pam_warn.so" >> /etc/pam.d/other
echo "password required pam_deny.so" >> /etc/pam.d/other

echo "session required pam_unix_session.so" >> /etc/pam.d/other
echo "session required pam_warn.so" >> /etc/pam.d/other
echo "session required pam_deny.so" >> /etc/pam.d/other

# limits on the computational resources could be added

# show message for users who log in
echo "auth required pam_issue.so issue=/etc/issue" >> /etc/pam.d/login
# change the message
# echo "x" > /etc/issue

# disable remote login for users of the group wheel
echo "-:wheel:ALL EXCEPT LOCAL" >> /etc/security/access.conf

