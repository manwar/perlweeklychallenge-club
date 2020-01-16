#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub check_parens {
    my $expr = shift;
    $expr =~ s/\s+//g; # remove spaces
    my $count = 0;
    for (split //, $expr) {
        $count++ if $_ eq '(';
        if ($_ eq ')') {
            return 0 if $count == 0;
            $count--;
        }
    }
    return $count == 0 ? 1 : 0;
}

for ("()", "(  )", "(())", "( ( ))", ")(", "())()", 
    "((( ( ()))))",  "()()()()", "(())(())") {
        say "$_: ", check_parens($_) ? "OK" : "Not OK";
}
