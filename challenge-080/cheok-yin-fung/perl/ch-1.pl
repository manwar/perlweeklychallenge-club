#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku #080 Task 1
use strict;
use warnings;
#use Test::More tests => 5;
use feature qw/say/;

my @N;
if ($ARGV[0]) {@N = @ARGV;} else {@N = (1, 0, -1);}

sub smallest {
    my @arr = @_;
    my $lenarr = scalar @arr;
    my %space = ( $_  => undef ) for 1..(1 + $lenarr);

    foreach (@arr) {
        $space{$_} = 1 if $_ >= 1 and $_ <= $lenarr+1  ;
    }
    for (1..$lenarr+1) {
        if (!$space{$_}) {
            return $_;
        }
    }
}

say smallest(@N);

=pod
ok smallest(1, 2, 3) == 4, "pass test case 1 2 3";
ok smallest(5, 2, -2, 0) == 1, "pass test case 2";
ok smallest(1, 8, -1) == 2, "pass test case 3";
ok smallest(2, 0, -1) == 1, "pass test case 4";
ok smallest(1, 6, 7, 28, -5, 0, 2, 3) == 4, "pass test case 5";
=cut
