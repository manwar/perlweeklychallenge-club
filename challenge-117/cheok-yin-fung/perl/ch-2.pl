#!/usr/bin/perl
# The Weekly Challenge 117
# Task 2 Find Possible Paths
# Usage: ch-2.pl [size of triangle]
use strict;
use warnings;

my $N = $ARGV[0];

die "Usage: ch-2.pl [size of triangle]\n" 
    unless $ARGV[0] && $ARGV[0] =~ /^\d+$/;

my @newarr = (1);

while (scalar @newarr <= $N) {
    my @arr = @newarr;
    @newarr = (1);
    my $ord = scalar @arr;
    for my $i (1.. $ord - 1) {
        push @newarr, $arr[$i-1] + $arr[$i] + $newarr[$i-1];
    }
    $newarr[$ord] = $arr[$ord-1] + $newarr[$ord-1];
}

print "Number of Paths: ", $newarr[-1];
print "\n";


#   *  *  *  *  *  *  *
sub ways {
    my $K = $_[0];
    my $newstp = [ [''] ];

    while (scalar @{$newstp} <= $K) {
        my $stp = $newstp;
        my $ord = scalar @{$stp};
        $newstp = [ [ 'L' x $ord ] ];
        for my $i (1.. $ord - 1) { 
            push @{$newstp->[$i]}, $stp->[$i-1]->[$_] . 'R'
                for (0.. $stp->[$i-1]->$#*);
            push @{$newstp->[$i]}, $stp->[$i]->[$_] . 'L'
                for (0.. $stp->[$i]->$#*);
            push @{$newstp->[$i]}, $newstp->[$i-1]->[$_] . 'H'
                for (0.. $newstp->[$i-1]->$#*);
        }

        push @{$newstp->[$ord]}, $stp->[$ord-1]->[$_] . 'R'
            for (0.. $stp->[$ord-1]->$#*);
        push @{$newstp->[$ord]}, $newstp->[$ord-1]->[$_] . 'H'
            for (0.. $newstp->[$ord-1]->$#*);
    }

    return $newstp->[-1];
}


if ($N <= 10) {
    print join " ", @{ways($N)}; 
}
else {
    print "...Too many possible paths!";
}
print "\n";

