#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

# http://projectbritain.com/money.html

my @money = qw(£1 50p 1p 10p 5p 20p £2 2p);

#Converts £ to p
@money = "@money"=~s/£(\S+)/$1*100/gre =~ /\d+/g;

#This means the algo optimized for player2 (vs player1)
my $optimized = 1;

my $min = 1e99;
my $comb;

#This is a brute force algo, it outputs the final set of money
#for both players (if they both played optimally) but not in correct sequence
for my $pick (0.. 2 ** (2*@money)-1) {
    my @accu = (0,0);
    my @monay = @money;
    for my $pos (0..@monay-1) {
        my $val;
        if ($pick & 1 << $pos) {
            $val = shift @monay;
            
        } else {
            $val = pop @monay
        }

        $accu[$pos % 2] += $val;
    }
    if (($accu[$optimized] - $accu[!$optimized]) > 0 && ($min >$accu[$optimized] - $accu[!$optimized])) {
        $min = $accu[$optimized] - $accu[!$optimized];
        $comb = $pick;
    }
}
my @path;
say "@money";
for my $pos (0..@money-1) { 
    my $val;
    if ($comb & 1 << $pos) {
        $val = shift @money;
        
    } else {
        $val = pop @money
    }
    $path[$pos % 2] .= ">> $val ";
}

say "Player".($optimized+1).": " . $path[$optimized];
say "Player".($optimized).  ": " . $path[!$optimized];

