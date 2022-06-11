#!/usr/bin/env raku

say (2..100).grep({.is-prime and .comb.sum.is-prime});
