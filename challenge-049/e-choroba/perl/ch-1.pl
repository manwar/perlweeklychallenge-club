#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my $x = shift;
say smallest_multiple($x);

sub smallest_multiple {
    my ($n) = @_;
    my $r = $n;
    $r += $n until $r =~ /^[01]+$/;
    $r
}
