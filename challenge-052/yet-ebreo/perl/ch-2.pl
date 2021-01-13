#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

# http://projectbritain.com/money.html

my @money = qw(£1 50p 1p 10p 5p 20p £2 2p);

#Converts £ to p
@money = "@money"=~s/£(\S+)/$1*100/gre =~ /\d+/g;
my $rmax = 0;
my $lmax = 0;
sub check_lr {
    my ($arr,$turn,$lscore,$rscore) = @_;

    if ($turn == 0) {

        $lscore += $arr->[0];
        my @new_arr1 = @{$arr}[1..$#{$arr}];
        if ($#new_arr1) {
            check_lr(\@new_arr1,1,$lscore,$rscore);
        } 

        $rscore += $arr->[-1];
        my @new_arr2 = @{$arr}[0..$#{$arr}-1];
        if ($#new_arr2) {
            check_lr(\@new_arr2,1,$lscore,$rscore);
        } 
        if ($rscore>$rmax) {
            $rmax = $rscore;
        }
        if ($lscore>$lmax) {
            $lmax = $lscore;
        }
        return $lmax>$rmax?0:1;
    } else {
        my @new_arr3;
        if ($arr->[0]>$arr->[-1]) {
            @new_arr3 = @{$arr}[1..$#{$arr}];
        } else {
            @new_arr3 = @{$arr}[0..$#{$arr}-1];
        }
        if($#new_arr3) {
            check_lr(\@new_arr3,0,$lscore,$rscore);
        }
    }

}
say "Original Array: @money\n";
my @scores;
while (@money) {
    $rmax = $lmax = 0;
    my $ai_move = check_lr(\@money,0,0,0);
    if ($ai_move == 0) {
        $scores[0][0]+= $money[0];
        $scores[0][1].= ">> $money[0] ";
        shift @money;
    } else {
        $scores[0][0]+= $money[-1];
        $scores[0][1].= ">> $money[-1] ";
        pop @money;
    }
    my $random_move = int(rand(2));
    if ($random_move == 0) {
        $scores[1][0]+= $money[0];
        $scores[1][1].= ">> $money[0] ";
        shift @money;
    } else {
        $scores[1][0]+= $money[-1];
        $scores[1][1].= ">> $money[-1] ";
        pop @money;
    }

}

say "Optimized Score: $scores[0][0]";
say "Optimized Moves: $scores[0][1]\n";

say "Random Score:    $scores[1][0]";
say "Random Moves:    $scores[1][1]\n";

=begin
perl .\ch-2.pl
Original Array: 100 50 1 10 5 20 200 2

Optimized Score: 311
Optimized Moves: >> 100 >> 1 >> 200 >> 10

Random Score:    77
Random Moves:    >> 50 >> 2 >> 20 >> 5

perl .\ch-2.pl
Original Array: 100 50 1 10 5 20 200 2

Optimized Score: 306
Optimized Moves: >> 100 >> 1 >> 5 >> 200

Random Score:    82
Random Moves:    >> 50 >> 10 >> 20 >> 2
=cut