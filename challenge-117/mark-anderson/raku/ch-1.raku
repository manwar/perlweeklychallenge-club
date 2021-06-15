#!/usr/bin/env raku

use Lingua::EN::Numbers;

my $n = (sum 1..15) - (sum 'file.txt'.IO.comb(/\d+/));

say $n ~ ", Line " ~ cardinal($n).tc;
