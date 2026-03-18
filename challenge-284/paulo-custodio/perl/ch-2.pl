#!/usr/bin/env perl

# Perl Weekly Challenge 284 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/

use Modern::Perl;
my $input = "@ARGV";
my($list1, $list2) = split /,/, $input;
my @list1 = split ' ', $list1;
my @list2 = split ' ', $list2;

my @output;
while (@list2) {
    my $n = shift @list2;
    push @output, grep {$_ == $n} @list1;
    @list1 = grep {$_ != $n} @list1;
}
push @output, sort {$a <=> $b} @list1;

say "(",join(", ", @output),")";
