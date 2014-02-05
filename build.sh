#!/bin/bash

force=$2
if [ -n "$force" ]; then
    opt_force="-a"
else
    opt_force=""
fi

env=$1
case $env in
"live")
    base="http://yannkerherve.bitbucket.org/live/"
    dst="live"
    ;;
"dev")
    base="http://localhost:8000/"
    dst="dev"
    ;;
*)
    echo "Please specify dev/live"
    exit
    ;;
esac

perl -Iextlib/lib/perl5 extlib/bin/ttree -f /dev/null \
    --define url_base=$base \
    -s src -d $dst -r -v --color $opt_force \
    --ignore='.*tt' \
    --copy='\.(woff|eot|ttf|css|img|jpe?g|gif|svg|ico|less|js|png)$'
