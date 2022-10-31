#!/usr/bin/env perl
# Perl weekly challenge 189
# Task 2:  Array Degree
#
# See https://wlmb.github.io/2022/10/31/PWC189/#task-2-array-degree
use v5.36;
use experimental qw(for_list builtin);
my %degree;
my (%degree_of, %beginning_of, %ending_of, %length_of);
my $current;
for my($index,$value)(builtin::indexed @ARGV){
    ++$degree_of{$value};
    $beginning_of{$value}//=$index;  # starting index if previously unseen
    $ending_of{$value}=$index;       # last seen index
    $length_of{$value}=$ending_of{$value}-$beginning_of{$value};
    $current=$value
        if($degree_of{$current}<$degree_of{$value} # update $current if found better
           || $degree_of{$current}==$degree_of{$value}
              && $length_of{$current}>$length_of{$value});
}
say join " ", @ARGV, "->", @ARGV[$beginning_of{$current}..$ending_of{$current}];
