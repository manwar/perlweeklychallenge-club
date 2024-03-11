#!/bin/env raku

unit sub MAIN(*@N);

my %freq = @N.Bag;
put @N.sort({ %freq{$_}, -$_ }).join(',');
