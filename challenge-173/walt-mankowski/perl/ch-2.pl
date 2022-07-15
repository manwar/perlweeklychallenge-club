#!/usr/bin/env perl
use v5.36;
use bigint;
use List::Util qw(product);

# Task 2: Sylvester’s sequence
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 10 members of Sylvester's sequence.
# In number theory, Sylvester's sequence is an integer sequence in
# which each term of the sequence is the product of the previous
# terms, plus one.

my @sylvester;
push @sylvester, 1 + product @sylvester while @sylvester < 10;
say for @sylvester;

