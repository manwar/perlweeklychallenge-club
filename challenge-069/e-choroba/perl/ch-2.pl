#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub next_s {
    $_[0] . '0' . reverse($_[0]) =~ tr/01/10/r;
}

my $s = "";

$s = next_s($s) for 1 .. 30;
say $s;

__END__
real	0m1.572s
user	0m1.336s
sys	0m0.236s

Length of $s: 1073741823 (2 ** 30 - 1)
