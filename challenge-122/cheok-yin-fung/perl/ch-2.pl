#!/usr/bin/perl
# The Weekly Challenge 122
# Task 2 Basketball Points
use strict;
use warnings;
use v5.10.0;
use Algorithm::Combinatorics qw /combinations/;

my $S = $ARGV[0] || 5;
my @ans;

if ($S == 1) {
    @ans = ("1");
}
elsif ($S == 2) {
    @ans = ("11","2");
}
else {
    push @ans, reverse oneortwo_str($S)->@*;
    for my $k (1..int $S/3) {
        my @ans_three333;
        my $iter = combinations([0..$S-1-2*$k], $k);
        while (my $c = $iter->next) {
            my $str_t = "*" x $S;
            my $len = $S-2*$k;
            substr($str_t, $c->[0], 3) = "3";
            if ($k > 1) {
              for my $t (reverse 1..$k-1) {
                  substr($str_t, 2*($t-1)+$c->[$t], 3) = "3";
              }
            }            
            push @ans_three333, $str_t;
        }
        push @ans, @{expand($_)} for (reverse @ans_three333);
    }
}

say "Number of ways: " , scalar @ans;
say "";
say join "\n", @ans;

sub expand {
    my $str = $_[0];
    my @expand_arr;
    my $next_3;
    if ($str =~ /\*/) {
        my $pos = index($str,"*");
        my $next_3 = index($str, "3", $pos+1);
        my $len_of_stars =
                           $next_3 == -1 ? 
                           (length $str) - $pos :
                           $next_3-$pos;
    
        for my $onetwo (oneortwo_str($len_of_stars)->@*) {
            my $temp_str = $str;
            substr($temp_str, $pos, $len_of_stars) = $onetwo;
            push @expand_arr, @{expand($temp_str)};
        }
    }
    else {
        push @expand_arr, $str;
    }
    return [@expand_arr];
}


# codes from challenge 112
sub oneortwo_str {
    my $n = $_[0];
    my @one_or_two;
    return [] if $n == 0;
    return ["1"] if $n == 1;
    for my $i ($n%2+$n/2 .. $n-1) {
        my $iter = combinations([0..$i-1] , ($n-$i) );
        my $str = "1" x $i;
        while (my $c = $iter->next) {
            my $str_clone = $str;
            substr($str_clone, $_, 1) = "2" for (@{$c});
            push @one_or_two, $str_clone;
        }
    }
    push @one_or_two , "1" x $n;
    return [@one_or_two];
}
