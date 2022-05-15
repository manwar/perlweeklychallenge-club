#!/usr/bin/env perl
# Perl weekly challenge 164
# Task 2: Happy numbers
#
# See https://wlmb.github.io/2022/05/12/PWC164/#task-2-happy-numbers
use v5.12;
use warnings;
use List::Util qw(sum);
my $desired=8;
my $try=1;
my @found=();
while(@found<$desired){
    push @found,  $try if happy($try);
    ++$try;
}
say "The first $desired happy numbers are: ", join " ", @found;

sub happy {
    my $x=shift;
    my %seen;
    while(!$seen{$x}){
        $seen{$x}=1;
        $x=sum map {$_*$_} split "", $x
    }
    return $x==1;
}
