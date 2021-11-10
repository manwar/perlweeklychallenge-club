#!/usr/bin/env perl
# Perl weekly challenge 138
# Task 2: Split number
#
# See https://wlmb.github.io/2021/11/09/PWC138/#task-2-split-number
use v5.12;
use warnings;
use integer;
use List::Util qw(sum0);
use List::MoreUtils qw(pairwise);
use POSIX qw(floor);
N:
    foreach my $N(@ARGV){
        my $sqrt=floor sqrt($N);
        say("$_ is not a perfect square"),next unless $sqrt**2==$N;
        foreach(0..2**(length($N)-1)-1){
            say("Input: $N Output: 1"), next N if sum0(one_split($N,$_))==$sqrt;
        }
        say "Input: $N Output: 0";
}

sub one_split { # produce the n-th way to split a string
    my ($string, $counter)=@_;
    my @binary_counter=map {$_?"-":""}
         split "", sprintf "%0".length($string)."b", $counter;
    my @chars=split "", $string;
    return split "-", join "", pairwise {"$a$b" }@binary_counter, @chars;
}
