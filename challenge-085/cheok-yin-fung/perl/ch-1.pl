#!/usr/bin/perl
# The Weekly Challenge 085 - Task 1 Triplet Sum
# Usage: ch-1.pl (array of numbers)
# Example: ch-1.pl 0.44 0.6 1
use strict;
use warnings;
#use Test::More tests => 4;

sub diff {
    my ($a, $b, $c) = @_;
    return 0 if $a == $b || $b == $c || $c == $a;
    return 1;
}

sub trisum {
    my @R = @{$_[0]};
    @R = sort @R;
    my $L = scalar @R;
    my %h;
    for my $i (0..$L-1) {
        for my $j (0..$L-2) {
            for my $k (0..$L-3) {
                my ($i, $j, $k) = sort ($i, $j, $k);
                if ( diff($i,$j,$k) and !($h{"$i,$j,$k"}) ) {
                  $h{"$i,$j,$k"} = 1;
                  my $s = $R[$i]+$R[$j]+$R[$k];
                  if ($s > 1 and $s < 2) {
                    print ("  ", (join " + ", ($R[$i],$R[$j],$R[$k]) ),"\n");
                    print ("= ", $s, "\n" x 2);
                    return 1;
                  }
                }
            }
        }
    }
    return 0;
}

if ($ARGV[0]) {
    die "not enough parameters" if scalar @ARGV < 3;
    for my $term (@ARGV) {
        if (($term !~ /^(\+)?[0-9]+(\.)[0-9]+$/) 
                and ($term !~ /^(\+)?[1-9]+$/)) { 
            die "\"$term\" is not numeric"             #exception handling 
    }}
    print trisum([@ARGV]);
    print "\n";
} 
else {
    my @arry = (0.4, 0.4, 0.5, 0.6);
    print "array of positive real numbers: ", join " ", @arry;
    print "\n" x 2;
    print trisum([@arry]);
    print "\n";
}

=pod
ok(trisum([1.2,0.4,0.1,2.5]), "Example 1");
ok(trisum([0.2,1.5,0.9,1.1]) == 0, "Example 2");
ok(trisum([0.5,1.1,0.3,0.7]), "Example 3");
ok(trisum([0.33, 0.33, 0.33, 0.44]), "My Test Case 1");
=cut
