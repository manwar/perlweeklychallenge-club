#!/usr/bin env perl6
use lib '.';
use Test;
use ModuleCH02;

my @scores = 5, 4, 4, 3;

is-deeply ranking(@scores),
    Array[Int:D].new(1, 2, 2, 4),
    "Test standard ranking";

is-deeply ranking(@scores, :modified),
    Array[Int:D].new(1, 3, 3, 4),
    "Test modified ranking";

is-deeply ranking(@scores, :dense),
    Array[Int:D].new(1, 2, 2, 3),
    "Test dense ranking";
