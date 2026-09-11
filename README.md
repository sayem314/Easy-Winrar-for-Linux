# Easy-Winrar-for-Linux

Hi, this script installs the latest WinRAR (rar + unrar) on your Linux machine in a flick!

The installer auto-detects the current stable release from [rarlab.com](https://www.rarlab.com/download.htm), so it never goes stale.

## Install

```sh
wget -qO- git.io/rar.sh | sudo bash
```

or

```sh
curl -fsSL git.io/rar.sh | sudo bash
```

## Uninstall

```sh
sudo rm -f /usr/local/bin/rar /usr/local/bin/unrar /etc/rarfiles.lst /usr/local/lib/default.sfx
```

## Notes

- Installs to `/usr/local/bin`, so it shadows any distro-provided `unrar` without touching package-managed files
- x86_64 only — rarlab does not publish 32-bit or ARM builds of WinRAR for Linux
- Pin a specific version instead of auto-detecting: `WINRAR_VERSION=7.2.3 bash install-rar.sh`
- Downloads over HTTPS and extracts inside a private temp directory
