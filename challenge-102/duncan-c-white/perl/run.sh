#!/bin/sh -
perl -d:NYTProf ./ch-$1.pl 7
nytprofhtml
mkdir -p ~/public_html/rare
cp -pr nytprof/* ~/public_html/rare
