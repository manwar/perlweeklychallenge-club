#!/usr/bin/perl
# The Weekly Challenge 113
# Task 1 Represent Integer
use strict;
use warnings;

my $_N = $ARGV[0];
my $_D = $ARGV[1];

die "Usage: ch-1.pl [a positive integer] [a digit]\n" 
    unless $_N && $_N =~ /^\d+$/ && $_D =~ /^\d$/;

print representable($_N, $_D), "\n";



sub representable {
    my $N = $_[0];
    my $D = $_[1];
    
    if ($D == 0) {
        if ($N >= 100 || $N % 10 == 0) {
            return 1;
        }
        else {
            return 0;
        }
    }
    
    return 1 if $N >= 10*$D;   
    # important line; below we deal with $N < 10*$D only

    return 1 if $N % $D == 0;  # $N = $D + $D + ... + $D, esp $D == 1
    return 0 if $D == 2 || $D == 5;

    if ($D == 4 && $N > 10) {
        return $N % 2 == 0 ? 1 : 0;
    }

    if ($D == 8 && $N >= 40) {
        return $N % 2 == 0 ? 1 : 0;
    }

    if ($D == 6) {
        return 0 if $N % 2 != 0;
    }
 #   check on $D == 3, 7, 9 or remaining cases for $D == 4, 6 , 8
    return step_down($D, $N); # can be replaced by &last_digit
}

sub step_down {
    # Example   I: if N = 82, D = 9, it hints 82 = 9*7+19
    # Example  II: if N = 64, D = 7, it hints 64 = 7*1+57
    # Example III: if N = 30, D = 8, the set {8, 18, 28} ...
    # Example  IV: if N = 44, D = 6, it hints 44 = 6*3+26
    my $digit = $_[0];
    my $short = $_[1];
    my $temp_short = $short;
    do {
        return 1 if $temp_short =~ /$digit/;
        $temp_short -= $digit;
    } while ($temp_short > 0);   
    return 0;
}

sub last_digit {
    # Example   I: if N = 82, D = 9, it hints 82 = 72+10 = 9*8+10 = 9*7+19
    # Example  II: if N = 64, D = 7, it hints 64 = 14+50 = 7*2+50 = 7*1+57
    # Example III: if N = 30, D = 8, the set {8, 18, 28} ...
    # Example  IV: if N = 44, D = 6, it hints 44 = 24+20 = 6*4+20 = 6*3+26
    my $digit = $_[0];
    my $short = $_[1];
    my $last_digit_of_short = $short % 10;
    my $i = 1;
    while ($digit*$i < $short) {
        if ($digit*$i % 10  == $last_digit_of_short ) {
            return 1;
        }
        $i++;
    }
    return 0;
}


=pod
 Testing:
 for (my $i = 10; $i < 70; $i++) {
     print $i," " , representable($i, 7) , "\n";
 }
 for (my $i = 10; $i < 90; $i++) {
     print $i," " , representable($i, 9) , "\n";
 }
=cut
