#!/usr/bin/env perl

use 5.030;
use strict;
use warnings;

my @input = split //, <<>> =~ s/\s+//gr;

my @words;
$words[$_ % 8] .= $input[$_] for 0..$#input;

say join ' ', @words;


__DATA__

TASK #1
Square Secret Code

The squate secret code mechanism first removes any space from the original message. Then it lays down the message in a row of 8 columns. The coded message is then obtained by reading down the columns going left to right.

For example, the message is “The quick brown fox jumps over the lazy dog”.

Then the message would be laid out as below:

thequick
brownfox
jumpsove
rthelazy
dog

The code message would be as below:

tbjrd hruto eomhg qwpe unsl ifoa covz kxey

Write a script that accepts a message from command line and prints the equivalent coded message.
