#!/bin/sh

raku -e '(1 .. 1000).grep({ $_.is-prime && $_ == $_.flip }).join(q{ }).say;'
