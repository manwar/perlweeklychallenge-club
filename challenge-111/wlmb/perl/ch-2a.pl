#!/usr/bin/env perl
# Perl weekly challenge 111
# Task 2: Ordered letters
#
# See https://wlmb.github.io/2021/05/03/PWC111/#task-2-ordered-letters
use strict;
use warnings;
use v5.12;
use List::Util qw(all);
my $length=shift @ARGV;
foreach(<>){
    chomp;
    $_=lc $_;
    next unless m/^\w+$/; #Only allow word letters
    next unless length==$length;
    next unless sorted($_);
    say $_;
}

sub sorted {
    my @chars=split '', shift;
    return all {$chars[$_] le $chars[$_+1]} 0..$#chars-1;
}
