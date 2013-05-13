#!/bin/sh

echo "deploying dominick.me"
cd /home/deployer/apps/personal
git pull git@git.pyg8.com:dominick.me.git master
echo "recompiling scss"
source /etc/profile.d/rbenv.sh
sass --update tmpl/sass:public/css
echo "stopping server"
pkill -9 dal.native
echo "rebuilding"
source /etc/profile.d/opam.sh
ocamlbuild -use-ocamlfind src/dal.native
echo "starting server"
nohup /home/deployer/apps/personal/scripts/keepalive.sh &
