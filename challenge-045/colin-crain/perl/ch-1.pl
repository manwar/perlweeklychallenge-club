#! /opt/local/bin/perl
#
#       square_secret.pl
#
#       PWC 45 TASK #1
#         Square Secret Code
#             The squate secret code mechanism first removes any space from the
#             original message. Then it lays down the message in a row of 8
#             columns. The coded message is then obtained by reading down the
#             columns going left to right.
#
#             For example, the message is “The quick brown fox jumps over the lazy
#             dog”.
#
#             Then the message would be laid out as below:
#
#             thequick
#             brownfox
#             jumpsove
#             rthelazy
#             dog
#             The code message would be as below:
#
#                  tbjrd hruto eomhg qwpe unsl ifoa covz kxey

#             Write a script that accepts a message from command line and prints
#             the equivalent coded message.
#
#         method: To encode the message we need to prep the input, removing
#             spaces and lowercasing eveything. We then make a data structure,
#             an array of array references, to hold the output. Once we have
#             this container built, we first dice the string into an explicit
#             array of chars, then iterate through the list, pushing the chars
#             into one of the output sub-arrays, cycling the index as determined
#             by mod8 on the iterator, the input array index. A little joining
#             of first the subarrays and then the outer array for printing and
#             we're done.

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



# use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $input = shift @ARGV || "The quick brown fox jumps over the lazy dog";

## eliminate spaces and nonword chars, lowercase rest in one pass
$input = lc( join '', grep { /\w/ } split //, $input );

## create the output array data structure
push my @output, [] for (1..8);

## fill the output arrays
push $output[$_%8]->@*, substr $input, ($_), 1  for (0..(length $input) - 1);

## display the output arrays
say join ' ', map {join '', $_->@* } @output;


