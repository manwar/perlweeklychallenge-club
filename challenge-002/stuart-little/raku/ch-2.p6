#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(    
    Bool :f(:$from-base_35),
    Bool :t(:$to-base_35) = ! $from-base_35,
    *@ARGS,
    ) {
    my &cvrt=($from-base_35) ?? ({ $_.parse-base(35) }) !! ({ $_.Int.base(35) });
    say @ARGS[0].&cvrt;
}
