#!/bin/sh

raku -e '(3,0,2, -> $i, $j, $ { $i + $j} ... ∞).grep({ .is-prime }).unique[^13].sort.join(q{, }).say'
