#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-002/
# Challenge #2
# Write a script that can convert integers to and from a base35 representation,
# using the characters 0-9 and A-Y. Dave Jacoby came up with nice description about base35,
# in case you needed some background.
# https://gist.github.com/jacoby/764bb4e8a5d3a819b5fbfa497fcb3454

#Usage
# ch-2.pl --to-base35 <base-10-number>
# ch-2.pl --from-base35 <base-35-number>

use strict;

my @base = (0..9,'A' .. 'Y');

print to_base35($ARGV[1]) if ($ARGV[0] eq '--to-base35');
print from_base35($ARGV[1]) if ($ARGV[0] eq '--from-base35');


sub to_base35 {
    my ($i) = @_;

    return 0 if ($i == 0);

    my $sign = ($i =~ s/-//) ? '-' : '';

    my $result;

    while ($i > 0) {
        $result .= $base[$i % @base];
        $i = int($i / @base);
    }
    return $sign . reverse $result;
}

sub from_base35 {
    my ($t) = @_;
    $t = reverse $t;

    my $sign = ($t =~ s/-//) ? '-' : '';

    my $result = 0;

    for my $i (0..length($t)-1){
        my $c = substr($t, $i, 1);
        my ($index) = grep { $base[$_] eq $c } (0 .. @base-1);
        $result += $index * ( @base ** $i );
    }
    return $sign . $result;
}
