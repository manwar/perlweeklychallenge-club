#!/usr/bin/env perl
use strict;
use warnings;
my @aoa=([qw<I L O V E Y O U>], [qw<2 4 0 3 2 0 1 9>], [qw<! ? £ $ % ^ & * >]);
my @indexes=@ARGV==0?(2,3):@ARGV;

print "$_\n" for map {my $i=$_; join " ", map {$aoa[$_]->[$i]} 0..$#aoa} @indexes; 
