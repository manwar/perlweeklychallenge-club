#!/usr/bin/env perl
# Perl weekly challenge 193
# Task 2:  Odd String
#
# See https://wlmb.github.io/2022/11/29/PWC193/#task-2-odd-string
use v5.36;
use List::Util qw(reduce);
use bigint; # in case of many-lettered words
sub str2num($str){ # convert a string into an array of differences and a number
    die "Only a..z allowed and >1 chars: $str" unless $str=~/^[a-z]{2,}$/;
    $str=lc $str; # normalize to lower case
    state $length=length $str;
    die "Length of string must be larger than 1: $str" unless $length>1;
    die "All strings musts have the same length: $str"
	unless length $str == $length;
    my ($next, @rest)=map {ord($_)-ord("a")} split "", $str;
    my $previous;
    reduce {51*$a+$b} # interpret elements as base-51 digits
           map {
               ($previous, $next)=($next, $_);
               $next-$previous+25
           } @rest
}
my %repetitions_of;
my %number_of;
++$repetitions_of{$number_of{$_}=str2num($_)} for @ARGV; # initialize hashes
my @odd = grep {$repetitions_of{$number_of{$_}}==1} keys %number_of; # filter odd's
say join(", ", @ARGV), " -> ", join(", ", @odd);
