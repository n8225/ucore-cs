#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

ln -s /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

# this installs a package from fedora repos

yum -q makecache -y --disablerepo='*' --enablerepo='crowdsec_crowdsec'

dnf5 -y  --setopt=install_weak_deps=False install \
  crowdsec-firewall-bouncer-nftables \
  nebula \
  tailscale \
  micro 
dnf5 clean all

rm -rf /var/lib/dnf
