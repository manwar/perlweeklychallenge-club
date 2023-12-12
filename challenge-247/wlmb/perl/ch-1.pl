#!/usr/bin/env perl
# Perl weekly challenge 247
# Task 1:  Secret Santa
#
# See https://wlmb.github.io/2023/12/11/PWC247/#task-1-secret-santa
use v5.36;
use experimental qw(postderef);
my %last_name;
my %person;
# Input from STDIN, one name per line
while(<>){
    chomp;
    my (undef,$last)=split " ";
    $last_name{$_}=$last;
    push $person{$last}->@*, $_;
}
my @families=sort {$person{$b}->@*<=>$person{$a}->@*} keys %person;
my $first_giver;
while(@families){
    my $family_giver=shift @families;
    my $giver=shift $person{$family_giver}->@*;
    $first_giver//=$giver;
    push @families, $family_giver if $person{$family_giver}->@*;
    my $receiver=$families[0]?$person{$families[0]}[0]:$first_giver;
    say "$giver -> $receiver";
}
