#!/usr/bin/env perl

# Challenge 108
#
# TASK #2 - Bell Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to display top 10 Bell Numbers. Please refer to wikipedia page
# for more informations.
#
# Example:
# B0: 1 as you can only have one partition of zero element set
# B1: 1 as you can only have one partition of one element set {a}.
# B2: 2
#    {a}{b}
#    {a,b}
# B3: 5
#    {a}{b}{c}
#    {a,b}{c}
#    {a}{b,c}
#    {a,c}{b}
#    {a,b,c}
# B4: 15
#    {a}{b}{c}{d}
#    {a,b,c,d}
#    {a,b}{c,d}
#    {a,c}{b,d}
#    {a,d}{b,c}
#    {a,b}{c}{d}
#    {a,c}{b}{d}
#    {a,d}{b}{c}
#    {b,c}{a}{d}
#    {b,d}{a}{c}
#    {c,d}{a}{b}
#    {a}{b,c,d}
#    {b}{a,c,d}
#    {c}{a,b,d}
#    {d}{a,b,c}

use Modern::Perl;
use Data::Dump 'dump';

my $N = shift || 10;
my $bell = bell();
for (1..$N) {
    print $bell->(), " ";
}
print "\n";

sub bell {
    my $n = -1;
    my @bell;
    return sub {
        $n++;
        if ($n==0) {
            push @bell, [1];
            return 1;
        }
        else {
            push @bell, [$bell[$n-1][$n-1]];
            for my $i (1..$n) {
                $bell[$n][$i] = $bell[$n-1][$i-1] + $bell[$n][$i-1];
            }
            return $bell[$n][0];
        }
    };
}
