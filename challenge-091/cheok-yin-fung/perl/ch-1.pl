#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku - 090
# Task 1: Count Number
# Usage: ch-1.pl $N

use strict;
use warnings;
#use Test::More tests => 3;

my $N = $ARGV[0] ? $ARGV[0] : 1048576 ;
my @NAME = qw/zero one two three four five six seven eight nine/;

sub newnumber {
    my $n = $_[0];
    my @digit = ((split "", $n), "E");
    my @segment = ();
    my @d_segment = ();

    my $k = 0;
    while ($k <= (length $n) - 1) {
        my $r = 1;
        while ($digit[$k] eq $digit[$k+1]) { 
            $r++;
            $k++;
        }
        die "I cannot say it." if $r > 9;
        push @segment, $r;
        push @d_segment, $digit[$k];
        $k++;
    }


    my $ans;
    for (0..$#segment) {
        $ans .= $segment[$_].$d_segment[$_];
    }

    my @d_ans = split "", $ans;
    my $outp = "";
    for (my $i = 0; $i < length $ans; $i=$i+2) {
        $outp .= $NAME[$d_ans[$i]]." ".$d_ans[$i+1];
        if ($i == (length $ans) - 2) {$outp .= ".\n"} else {$outp .= ", "}
    }
    return [$ans, $outp];
}
unless ($ARGV[0]) {print "input: ", 1048576 , "\n"}
print "output: ", newnumber($N)->[0], "\n";
print newnumber($N)->[1], "\n";

=pod
ok( newnumber(1122234)->[0] == 21321314 , "Example 1");
ok( newnumber(2333445)->[0] == 12332415 , "Example 2");
ok( newnumber(12345)->[0] == 1112131415 , "Example 3");
=cut
