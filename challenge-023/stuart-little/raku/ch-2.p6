#!/usr/bin/env perl6
use v6;

my @PRIMES=(2..*).grep(*.is-prime);

sub fct($n,@a) {
    $n.abs == 1 && return @a;
    my $fact=@PRIMES.first($n %% *);
    return fct(($n div $fact), (|@a,$fact));    
}

say @*ARGS[0].Int.&fct(())

# run as <script> <integer>
