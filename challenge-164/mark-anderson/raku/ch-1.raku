#!/usr/bin/env raku
use Test;

is-deeply (2, 3, 5, 7 ... 999).grep({.is-prime and .item eq .flip}),
(2, 3, 5, 7, 11, 101, 131, 151, 181, 191, 313, 353, 373, 383, 727, 757, 787, 797, 919, 929);
