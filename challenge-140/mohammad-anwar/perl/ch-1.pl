#!/usr/bin/perl

=head1

Week 140:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-140

Task #1: Add Binary

    You are given two decimal-coded binary numbers, $a and $b.

    Write a script to simulate the addition of the given binary numbers.

=cut

package Binary;

use strict;
use warnings;

use overload '+' => 'add', '""' => 'stringify';

sub new {
    my ($class, $value) = @_;
    my $self = {
        binary  => $value,
        decimal => oct("0b" . $value),
    };

    bless $self, $class;

    return $self;
}

sub add {
    my ($self, $other) = @_;

    return Binary->new( sprintf("%b", $self->{decimal} + $other->{decimal}) );
}

sub stringify {
    my ($self) = @_;

    return $self->{binary};
}

package main;

use Test::More;

my $ex1 = Binary->new('11')  + Binary->new('1');
my $ex2 = Binary->new('101') + Binary->new('1');
my $ex3 = Binary->new('100') + Binary->new('11');

is("$ex1", '100', 'Example 1');
is("$ex2", '110', 'Example 2');
is("$ex3", '111', 'Example 3');

done_testing;
