#!/bin/env raku

unit sub MAIN(Int:D $int);

put $int.flip.comb.rotor(3, :partial)».join.join(',').flip;
