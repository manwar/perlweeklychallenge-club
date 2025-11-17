#!/usr/bin/perl
use 5.038;
use warnings;

my $phone = shift;

$phone =~ s/[ \-]//g;
my @groups = $phone =~ /.{1,3}/g;

if (length $groups[-1] == 1) {
    $groups[-2] =~ s/(.)$//;
    $groups[-1] = "$1$groups[-1]";
}

say join q{-}, @groups;
