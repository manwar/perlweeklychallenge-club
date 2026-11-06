#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($year) = @ARGV;

my @elements = qw/ Metal Metal Water Water Wood Wood Fire Fire Earth Earth /;
my @animals = qw/ Monkey Rooster Dog Pig Rat Ox Tiger Rabbit Dragon Snake Horse Goat /;

say $elements[$year % 10], ' ', $animals[$year % 12];
