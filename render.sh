#! /bin/bash

for f in live/*.html; do
    perl render-template.pl $f
done
