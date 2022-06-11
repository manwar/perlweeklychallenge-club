#!/bin/sh

raku -e '(2 .. 100).grep({ .is-prime }).grep({ ([+] .comb).is-prime }).join(q{, }).say;'
