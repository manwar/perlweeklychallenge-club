#!/usr/bin/env perl

# perl ch-1.pl 7
use v5.20;

$_ = pop;

my @n = qw( 0 one two three four five six seven eight nine );
sub l { length @n[@_] }

1while s/[^4]$/$n[$&] is $n[l $&], ${\l $&}/;
say ucfirst s/4/four is magic./r
