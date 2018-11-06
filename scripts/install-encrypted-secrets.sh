#!/bin/bash
set -e

if [[ $EUID -eq 0 ]]; then
  echo "This script MUST NOT be run as root." 1>&2
  exit 1
fi

echo "Installing secrets as $(whoami)."

SECRETS_PATH=~/.secrets

update_secrets() {
  # https://askubuntu.com/questions/56326/how-do-i-rename-a-directory-via-the-command-line
  echo "Updating public secrets path."
  SECRETS_PATH_TMP=~/.secrets_tmp
  echo "Making backup of existing secrets (if any)."
  mv $SECRETS_PATH $SECRETS_PATH_TMP 2>/dev/null || true
  echo "Moving default secrets to new secrets path."
  mv ~/Private $SECRETS_PATH
  echo "Updating ecryptfs default secrets path."
  echo $SECRETS_PATH > ~/.ecryptfs/Private.mnt
  echo "Restoring saved secrets (if any)."
  cp -R $SECRETS_PATH_TMP/. $SECRETS_PATH 2>/dev/null || true
  rm -r $SECRETS_PATH_TMP 2>/dev/null || true
  # chmod 700 $SECRETS_PATH && rm -rf $SECRETS_PATH ~/.ecryptfs ~/.Private
}

setup_secrets() {
  # https://manpages.debian.org/stretch/ecryptfs-utils/ecryptfs-setup-private.1.en.html
  # https://wiki.archlinux.org/index.php/ECryptfs#Manual_setup
  # ecryptfs-setup-private --nopwcheck --noautomount 
  echo "Setting up encrypted secrets folder."
  LOGINPASS=vagrant
  MOUNTPASS=`cat /proc/sys/kernel/random/uuid`
  USER=vagrant
  ecryptfs-umount-private || true
  ecryptfs-setup-private --username $USER --loginpass $LOGINPASS --mountpass $MOUNTPASS
}

mount_secrets() {
  echo "Mounting encrypted secrets folder."
  ecryptfs-mount-private
}

remove_secrets() {
  echo "Removing secrets as $(whoami)."
  PRIVATE=`cat ~/.ecryptfs/Private.mnt 2>/dev/null || echo $HOME/Private`
  echo "Secrets found at: $PRIVATE"
  ecryptfs-umount-private 2>/dev/null  || true
  echo "Updating permissions."
  chmod 700 $PRIVATE 2>/dev/null  || true
  echo "Removing secrets."
  rm -rf $PRIVATE ~/.Private ~/.ecryptfs 2>/dev/null  || true
  echo "Finished removing secrets as $(whoami)."
}

remove_secrets || true
setup_secrets && update_secrets
# mount_secrets
echo "Showing uninstall information."
ecryptfs-setup-private --undo
echo "Listing mounted secrets in $SECRETS_PATH:"
ls $SECRETS_PATH -al
echo "Run ecryptfs-mount-private to mount your encrypted secrets."
echo "Run ecryptfs-umount-private to unmount your encrypted secrets."
echo "Finished installing secrets as $(whoami)."

# References:
# https://askubuntu.com/questions/574110/how-to-use-ecryptfs-with-a-non-home-directory
# https://www.howtoforge.com/tutorial/how-to-encrypt-directories-with-ecryptfs-on-ubuntu-16-04/
# http://ecryptfs.org/downloads.html
# http://ecryptfs.org/documentation.html
# https://www.techrepublic.com/article/how-to-install-and-use-ecryptfs-on-ubuntu/
# https://askubuntu.com/questions/1029249/how-to-encrypt-home-on-ubuntu-18-04
# https://github.com/google/fscrypt
# https://en.wikipedia.org/wiki/Dm-crypt
# https://security.stackexchange.com/questions/29535/full-disk-encryption-within-a-vm-how-secure-is-it
# https://askubuntu.com/questions/1034079/how-do-i-install-18-04-using-full-disk-encryption-with-two-drives-ssd-hdd
# https://help.ubuntu.com/community/ManualFullSystemEncryption
# http://www.cim.mcgill.ca/~anqixu/blog/index.php/2018/06/20/install-18-04-on-encrypted-partitions-xps15-cuda/
# https://www.kernel.org/doc/html/v4.18/filesystems/fscrypt.html
# https://github.com/google/fscrypt#setting-up-fscrypt-on-a-directory
# https://help.ubuntu.com/lts/serverguide/ecryptfs.html.en
# https://unix.stackexchange.com/questions/185170/non-interactive-ecryptfs-directory-encrypt-decrypt
# https://htmlpreview.github.io/?https://github.com/dustinkirkland/ecryptfs-utils/blob/master/doc/ecryptfs-faq.html
# https://wiki.archlinux.org/index.php/ECryptfs