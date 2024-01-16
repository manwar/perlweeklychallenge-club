#!/usr/bin/env perl

# The Weekly Challenge 247 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/
#
# Task 1 - Secret Santa 
#

use strict;
use warnings;
use v5.28;
use List::Util qw /shuffle/;
use Data::Dump qw(dump);

my @examples = (
    [ 'Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross'],
    [ 'Mr. Wall', 'Mrs. Wall', 'Mr. Anwar' ],
);



sub secret_santa_generator {
    my $temp = shift;
    my @names = shuffle @$temp;
    my @receivers = shuffle @names;
    my @asignated;

    foreach my $giver (@names) {
        $giver =~ /(\w+)$/;
        my $family_name = $1;

        my @eligibles = grep {$_ !~ /$family_name/} @receivers; # The elegibles are not family member
        if (scalar @eligibles == 0) {
            @eligibles = grep {$_ ne $giver} @receivers; # The elegibles are family member 
        }

        my $the_chosen = shift @eligibles;
        push( @asignated, {$giver => $the_chosen});

        @receivers = shuffle grep { $_ ne $the_chosen } @receivers;
    }

    return \@asignated;
}

for my $elements (@examples) {
    my $secret_santa = secret_santa_generator $elements; 

    say 'Input : @lang = ', dump(@$elements);
    say 'Output : ', dump(@$secret_santa);
    say ' ';
}
