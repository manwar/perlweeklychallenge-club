#!/usr/bin/env perl
# Perl weekly challenge 291
# Task 2:  Poker Hand Rankings
#
# See https://wlmb.github.io/2024/10/14/PWC291/#task-2-poker-hand-rankings
use v5.36;
use List::Util qw(product sum);
my @hand_names= ("Five_of_a_hand",
		 "Straight flush",
		 "Four of a kind",
		 "Full house",
		 "Flush",
		 "Straight",
		 "Three of a kind",
		 "Two pairs",
		 "One pair",
		 "High card"
    );
my @hand_counts=(0,
		 10*4,
		 13*(52-4),
		 13*4*12*6,
		 4*(fact(13)/fact(8)/fact(5)-10),
		 10*4**5-40,
		 13*12*11*4**3/2,
		 13*6*12*6*11*4/2,
		 13*6*fact(12)/fact(9)/fact(3)*4**3,
		 (fact(13)/fact(8)/fact(5)-10)*(4**5-4)
    );
say "$hand_names[$_]: $hand_counts[$_]" for 0..@hand_names-1;
say "Sum: ", sum(@hand_counts),
    "\nExpected: ",
    fact(52)/fact(52-5)/fact(5);

sub fact($n){
    product(1..$n)
}
