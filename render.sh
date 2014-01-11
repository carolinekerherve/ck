#! /bin/bash

for f in dst/*.html; do
    perl render-template.pl $f
done
