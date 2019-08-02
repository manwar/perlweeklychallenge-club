#!/usr/bin/perl
use strict;
use warnings;
no warnings 'recursion';
use feature qw/say/;

sub ack {
    my ($m, $n) = @_;
    return $n + 1 if $m == 0;
    return ack($m - 1, 1) if $n == 0;
    return ack($m - 1, ack($m, $n-1));
}
say ack 3, 4;
