#!/usr/bin/env perl6
use v6;

my %memo=((2,3,5) X=> 1).Hash;

sub smth5p($n) { %memo{$n} && return True; return (my $den=(2,3,5).first({ $n %% $_ })) ?? (%memo{$n div $den} && (%memo{$n}=1).Bool || False) !! (False) }

(2..@*ARGS[0].Int).grep(*.&smth5p).say

# run as <script> <number $n> to return the 5-smooth numbers innthe range 2..$n
