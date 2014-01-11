#!/bin/bash


perl -Iextlib/lib/perl5 extlib/bin/ttree -f /dev/null \
    --define url_base="http://localhost:8000/" \
    -s src -d dst -r -v --color \
    --ignore='.*tt' \
    --copy='\.(woff|eot|ttf|css|img|jpe?g|gif|svg|ico|less|js|png)$'
