#!/usr/bin/perl

# Perl Weekly Challenge - 068
#
# Task 1 - 0/1 String
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;
use Digest::SHA1 qw(sha1_hex);

my $s = '';
for my $i (1 .. 30) {
    print STDERR '.';
    $s = $s . '0'. switch(reverse($s));
}
print STDERR "\n";

printf "S30: length=%s, SHA1=%s\n", 
  formatNumber(length($s)), sha1_hex($s);

sub reverse {
    join('', split(//, $_[0]));
}

sub switch {
    $s = $_[0];
    $s =~ tr/01/10/;
    return $s;
}

sub formatNumber {
    my ($n) = @_;

    my @n;

    unshift(@n, $1) while ($n =~ s/(\d{3})$//);
    
    return join(',', $n, @n);
}
