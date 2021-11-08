#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

my @player_ages = (
    [ 20, "Alex" ],
    [ 28, "Joe" ],
    [ 38, "Mike" ],
    [ 18, "Alex" ],
    [ 25, "David" ],
    [ 18, "Simon" ],
);

my @player_names = (
    [ "Alex",  "Stewart" ],
    [ "Joe",   "Root" ],
    [ "Mike",  "Gatting" ],
    [ "Joe",   "Blog" ],
    [ "Alex",  "Jones" ],
    [ "Simon", "Duane" ],
);

say join "\n", hash_join( \@player_ages, \@player_names );

sub hash_join ( $array1, $array2 ) {
    my @output;
    my $hash = {};
    for my $e ( $array1->@* ) {
        my ( $age, $firstname ) = $e->@*;
        push $hash->{$firstname}->{age}->@*, $age;
    }
    for my $e ( $array2->@* ) {
        my ( $firstname, $lastname ) = $e->@*;
        push $hash->{$firstname}->{lastname}->@*, $lastname;
    }
    for my $firstname ( sort keys $hash->%* ) {
        next unless defined $hash->{$firstname}{age};
        next unless defined $hash->{$firstname}{lastname};
        my @ages      = $hash->{$firstname}{age}->@*;
        my @lastnames = $hash->{$firstname}{lastname}->@*;

        for my $age ( reverse sort @ages ) {
            for my $lastname ( reverse sort @lastnames ) {
                push @output, join ",\t", '   ' . $age, $firstname, $lastname;
            }
        }
    }
    return join "\n", @output;
}
