#!/usr/bin/env raku

say (1..1000).grep({.is-prime and .item eq .flip});
