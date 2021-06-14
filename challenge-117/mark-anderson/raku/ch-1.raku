#!/usr/bin/env raku

use Lingua::EN::Numbers;

my @f = 'file.txt'.IO.comb(/\d+/);
my @n = '1'..@f+1;
my $n = (@n (-) @f).keys.head;
say ($n, cardinal($n).tc).join(', Line ');
