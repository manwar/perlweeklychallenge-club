#!/usr/bin/env perl6
use v6;

sub F($n) { $n==0 && return 1; return $n - M(F($n-1)) }

sub M($n) { $n==0 && return 0; return $n - F(M($n-1)) }

my $n=@*ARGS[0].Int;

say "F: ", F($n);
say "M: ", M($n);

# run as <script> <function argument (non-negative integer)>
