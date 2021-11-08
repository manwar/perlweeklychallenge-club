#!/usr/bin/env perl
# Perl weekly challenge 114
# Task 2: Higher integer set bits
#
# See https://wlmb.github.io/2021/05/24/PWC114/#task-2-next-palindrome-number
use strict;
use warnings;
use v5.12;
use Scalar::Util qw(looks_like_number);
use POSIX qw(floor);

foreach my $N(@ARGV){
    die "Usage: ./ch-2.pl n m ... with positive integer arguments"
	unless looks_like_number $N and $N>0 and $N==floor $N;
    #convert to binary and add leading 0
    my $binary="0". sprintf("%b", $N);
    my $next_binary=$binary;
    #replace least significant 01 to 10 and shift following 1's to the right
    $next_binary=~s/01(1*)(0*)$/10$2$1/;
    my $next_dec=sprintf "%d", oct("0b$next_binary"); #convert to decimal
    say "$N ($binary)=>$next_dec ($next_binary)";
}
