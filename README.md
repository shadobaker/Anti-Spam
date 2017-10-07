# **SHADOBAKER** #

[![Library](https://img.shields.io/badge/TDLib-beta-brightgreen.svg)](https://core.telegram.org/tdlib)
[![Telegram-bot](https://img.shields.io/badge/TDCli-Bitbucket-green.svg)](https://valtman.name/telegram-bot)
[![Lua](https://img.shields.io/badge/Lua-5.2-blue.svg)](https://www.lua.org/)
[![Redis](https://img.shields.io/badge/Redis-3.2.8-red.svg)](https://redis.io/)



### An administration Telegram bot using Telegram-cli

# Installation

Debian/Ubuntu and derivatives:
```bash
# Tested on Ubuntu 16.04
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install git redis-server lua5.2 liblua5.2-dev lua-lgi libnotify-dev unzip tmux -y && add-apt-repository ppa:ubuntu-toolchain-r/test && sudo apt-get update && apt-get upgrade && sudo apt-get install libconfig++9v5 libstdc++6 && sudo apt autoremove
```                   
In case of errors like `version GLIBCXX_3.4.21 not defined`, download manually libstdc++6 from [here](https://packages.ubuntu.com/xenial/libstdc++6), install the package with `dpkg -i` and repeat the previous step.

If you are not able to install the bot in Ubuntu 14, an upgrade to Ubuntu 16.04 is recommended. Upgrade from terminal: `sudo do-release-upgrade`

---------------------------------

After installing the dependencies, lets install the bot:
```bash
 git clone https://github.com/shadobaker/Anti-Spam
 cd Anti-*
 chmod +x C
 ./C install
 ./C config
 ./C login-Cli # Will ask you for a phone number & confirmation code.
 ./C login-Api
 ./C Change-Login #Changed Login
 ./C start
```

[SHADOBAKER](https://github.com/shadobaker)

SHADOBAKER Channels:
--------------------
[SHADOBAKER](https://github.com/shadobaker/Anti-Spam)

-------------------
More information [SHADOBAKER](https://t.me/shadobakerm)


