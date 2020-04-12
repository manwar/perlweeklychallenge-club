#!/usr/bin/perl

use strict;
use warnings;
use v5.28;

sub perm
{
    state $n = 0;
	my ($k, $perm, @set) = @_;
	unless (@set) {
        ++$n;
        printf "%2d %s\n", $n, $perm if $k == $n;
        return $k == $n;
    }
	foreach (0..$#set) {
        return 1 if perm($k, $perm.$set[$_], @set[0..$_-1], @set[$_+1..$#set]);
    }
}

#----------------------------------

die "Usage: $0 N kth\n" if @ARGV != 2;
my @inp = 1..$ARGV[0];
my $k = $ARGV[1];
perm($k, '', @inp);
exit 0;
