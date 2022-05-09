#!/bin/env raku

unit sub MAIN(Str:D \ISBN);

put (10 - ([+] ISBN.comb(/\d/)[^12] Z* |(1,3) xx *) % 10) % 10;
