#!/bin/env raku

unit sub MAIN(*@n);

put [+] @n.combinations(2).map({ .[0] +& .[1] });
