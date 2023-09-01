#!/usr/bin/perl

# You are given a list of passenger details in the form “9999999999A1122”,
# where 9 denotes the phone number, A the gender, 1 the age and 2 the seat
# number.  Write a script to return the count of all senior citizens (age >=
# 60).

use 5.036;
use utf8;

package Passenger;

sub new ($class, %args) {
    my $details = $args{details} or die 'No details';
    $details =~ m{
        \A
        (?<phone>\d+)
        (?<gender>[[:alpha:]])
        (?<age>\d{2})
        (?<seat>\d{2})
        \z
    }x or die "Invalid details $details";
    return bless {%+}, $class;
}

sub AUTOLOAD ($self) {
    our $AUTOLOAD;
    my $attr = $AUTOLOAD =~ s/.*:://r;
    return $self->{$attr};
}

package main;

sub passengers (@details) {
    return map { Passenger->new(details => $_) } @details;
}

sub senior_citizens (@passengers) {
    return grep { $_->age >= 60 } @passengers;
}

say scalar senior_citizens(passengers(qw(
    7868190130M7522 5303914400F9211 9273338290F4010
)));
say scalar senior_citizens(passengers(qw(
    1313579440F2036 2921522980M5644
)));
