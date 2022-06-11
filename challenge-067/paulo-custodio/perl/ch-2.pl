#!/usr/bin/env perl

# Challenge 067
#
# TASK #2 › Letter Phone
# Submitted by: Mohammad S Anwar
#
# You are given a digit string $S. Write a script to print all possible letter
# combinations that the given digit string could represent.
#
# Letter Phone
#
#
# Example:
#   Input: $S = '35'
#
#   Output: ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"].

use Modern::Perl;
use Iterator::Array::Jagged;

my %digits = (
    1   => ['_', ',', '@'],
    2   => [qw( a b c )],
    3   => [qw( d e f )],
    4   => [qw( g h i )],
    5   => [qw( j k l )],
    6   => [qw( m n o )],
    7   => [qw( p q r s )],
    8   => [qw( t u v )],
    9   => [qw( w x y z )],
    '*' => [' '],
);

my $s = shift||"";
my @out = letter_phone($s);
say "[", join(", ", map {'"'.$_.'"'} @out), "]";

sub letter_phone {
    my($s) = @_;
    my @s = map {$digits{$_}} split(//, $s);
    my $it = Iterator::Array::Jagged->new(data => \@s);
    my @out;
    while (my @set = $it->next) {
        push @out, join("", @set);
    }
    return sort @out;
}
