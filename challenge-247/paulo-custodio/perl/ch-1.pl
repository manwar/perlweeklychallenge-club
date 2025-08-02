#!/bin/env perl

# Challenge 247
#
# Task 1: Secret Santa
# Submitted by: Andreas Voegele
#
# Secret Santa is a Christmas tradition in which members of a group are randomly
# assigned a person to whom they give a gift.
#
# You are given a list of names. Write a script that tries to team persons from
# different families.
# Example 1
#
# The givers are randomly chosen but don't share family names with the receivers.
#
# Input: @names = ('Mr. Wall',
#                  'Mrs. Wall',
#                  'Mr. Anwar',
#                  'Mrs. Anwar',
#                  'Mr. Conway',
#                  'Mr. Cross',
#                 );
#
# Output:
#
#     Mr. Conway -> Mr. Wall
#     Mr. Anwar -> Mrs. Wall
#     Mrs. Wall -> Mr. Anwar
#     Mr. Cross -> Mrs. Anwar
#     Mr. Wall -> Mr. Conway
#     Mrs. Anwar -> Mr. Cross
#
# Example 2
#
# One gift is given to a family member.
#
# Input: @names = ('Mr. Wall',
#                  'Mrs. Wall',
#                  'Mr. Anwar',
#                 );
#
# Output:
#
#     Mr. Anwar -> Mr. Wall
#     Mr. Wall -> Mrs. Wall
#     Mrs. Wall -> Mr. Anwar

use Modern::Perl;

my @people = @ARGV;

my %to_receive; $to_receive{$_}=1 for @people;

for my $giver (@people) {
    my @receivers = grep {!same_family($_, $giver)} sort keys %to_receive;
    if (!@receivers) {
        @receivers = grep {$_ ne $giver} sort keys %to_receive;
    }
    @receivers or die;
    my $receiver = shift @receivers;
    delete $to_receive{$receiver};

    say $giver," -> ", $receiver;
}

sub same_family {
    my($a, $b) = @_;
    for ($a, $b) {
        s/Mrs?\. //;
    }
    return $a eq $b;
}
