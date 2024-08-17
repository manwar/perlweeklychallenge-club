#!/usr/bin/env perl

# The Weekly Challenge 272 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/
#
# Task 1 - Defang IP Address
#

use strict;
use warnings;
use v5.28;

my @examples = ('1.1.1.1', '255.101.1.0');

sub defang_ip_address {
    my $ip = shift;
    $ip =~ s/\./\[\.\]/g;

    return $ip;
}

for my $elements (@examples) {
    my $dia = defang_ip_address $elements;

    say 'Input : $ip = ', $elements;
    say 'Output : ', $dia;
    say ' ';
}
