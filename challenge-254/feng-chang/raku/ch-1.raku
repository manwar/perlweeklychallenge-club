#!/bin/env raku

unit sub MAIN(Int:D $n);

put ($n**⅓ +0.5).Int³ == $n;
