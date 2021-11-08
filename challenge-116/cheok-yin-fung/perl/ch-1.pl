#!/usr/bin/perl
# The Weekly Challenge 116
# Task 1 Number Sequence
# Usage: ch-1.pl $N
use strict;
use warnings;
# use Test::Simple tests => 7;

my $N = $ARGV[0] || 12345;

die "Please input an integer larger or equal to 10.\n"
    unless $N =~ /^\d\d+$/;

print "Impossible to split.\n"
    unless (determine($N));


# I found that I had misunderstood the meaning of "consecutive"
# after the first commit.
# Removing some of the pound signs below, we can find 
# numbers which can be split into "integer seq diff by 1"


sub determine {
    my $num = $_[0];
    $num =~ s/^0+//;
    my $yN;    
    my $div_len = int((1+(length $num))/2);
    for my $k (1..$div_len) {
        $yN = $num;
        my $bool_next = 1;
        my $bool_next_i = undef;
#       my $bool_next_d = undef;
        my $f = substr($yN , 0, $k);
        my $f_i;
#       my $f_d;
        my @arr;
        while ($bool_next && $yN ne "") {
            $yN =~ s/^$f//;
            push @arr, $f;
            $f_i = $f+1;
#           $f_d = $f-1;
            $bool_next_i = $yN =~ /^$f_i/;
#           $bool_next_d = $yN =~ /^$f_d/;
##          $bool_next = $bool_next_i || $bool_next_d;
            $bool_next = $bool_next_i;
            $f = $f_i if $bool_next_i;
#           $f = $f_d if $bool_next_d;
        } 
        if ($yN eq "") {
            print join ",", @arr;
            print "\n";
            return 1;            
        }
    }
    return 0;
}

=pod
ok determine(10) == 0, "N = 10";
ok determine(1234) == 1, "example 1";
ok determine(91011) == 1, "example 2";
ok determine(10203) == 0, "example 3";
ok determine(103104) == 1, "N = 103104";
ok determine(123456789101112) == 1, "a large N";
ok determine(5405) == 0, "N = 5405";
=cut
