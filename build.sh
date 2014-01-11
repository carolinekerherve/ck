#!/bin/bash

force=$1
if [ -n "$force" ]; then
    opt_force="-a"
else
    opt_force=""
fi

perl -Iextlib/lib/perl5 extlib/bin/ttree -f /dev/null \
    --define url_base="http://yannkerherve.bitbucket.org/live/" \
    -s src -d live -r -v --color $opt_force \
    --ignore='.*tt' \
    --copy='\.(woff|eot|ttf|css|img|jpe?g|gif|svg|ico|less|js|png)$'
