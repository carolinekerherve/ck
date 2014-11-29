#! /bin/bash

tmpldir=${1:-"dev"}

for f in $tmpldir/*.html; do
    perl render-template.pl $f
done
