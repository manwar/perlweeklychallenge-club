#!/usr/bin/env perl
# Perl weekly challenge 092
# Task 1: Isomorphic strings.
# Test if two or more strings are isomorphic
# See https://wlmb.github.io/2020/12/22/PWC92/#task-1-isomorphic-strings
use warnings;
use strict;
use v5.10;

die "Usage ./ch-1.pl s0 s1 ... to compare two or more strings s0 s1 ..." unless @ARGV>=2;

my $first_string=shift @ARGV;
my $first_canon=canonical_form_of($first_string);
my $first_non_isomorphic;
while(my $string=shift @ARGV){
    $first_non_isomorphic=$string, last
		unless $first_canon eq canonical_form_of($string);
}
say $first_non_isomorphic
    ? "0: $first_string and $first_non_isomorphic are not isomorphic"
    : "1: All strings are mutually isomorphic";

sub canonical_form_of {
    my %map;
    my $current_letter="a";
    my $canon=join '', map {$map{$_}//($map{$_}=$current_letter++)} split //, shift;
}
