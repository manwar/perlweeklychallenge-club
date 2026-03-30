#!/usr/bin/env perl

# Perl Weekly Challenge 367 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/

use Modern::Perl;

@ARGV==1 or die "usage: $0 bin\n";
$_ = shift;
s/1(0+)0$/0${1}1/;
1 while s/0(.*)1(0*)1$/1${1}0${2}1/;

# ensure last bit is '1' whenever possible (string contains a '1')
if (/1/ && /0$/) {
    my $pos = rindex($_, '1');
    if ($pos >= 0) {
        substr($_, $pos, 1, '0');
        substr($_, -1, 1, '1');
    }
}
say $_;
