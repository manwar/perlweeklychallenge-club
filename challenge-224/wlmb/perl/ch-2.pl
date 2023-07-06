#!/usr/bin/env perl
# Perl weekly challenge 224
# Task 2:  Additive Number
#
# See https://wlmb.github.io/2023/07/03/PWC224/#task-2-additive-number
use v5.36;
use List::Util qw(max min);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    to check if the strings S1 S2... correspond to additive numbers.
    FIN
 INPUT: for(@ARGV){
     say("String should contain digits only: $_"), next INPUT unless /^\d+$/;
     my $length=length;
     FIRST: for my $length1(1..$length/2){ # no need to consider larger first numbers
	 my $copy=$_; # make a copy of input string
	 my $previous=substr $copy, 0, $length1, ""; # choose the starting number
	 for my $length2(1..$length/2){
	     # ignore numbers that are too large:
	     next FIRST if 2*max($length1,$length2) > $length - min($length1, $length2);
	     my $copy_of_copy=$copy;
	     my $current=substr $copy_of_copy, 0, $length2, "";
	     my $next=$previous + $current;
	     while($copy_of_copy=~s/^$next//){ # found next number in sequence?
		 say("$_ -> True"), next INPUT if length $copy_of_copy==0; # Finished?
		 ($current, $next)=($next, $current+$next)
	     }
	 }
     }
     say "$_ -> False";
}
