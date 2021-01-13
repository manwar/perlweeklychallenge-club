#! /opt/local/bin/perl
#
#       colorful.pl
#
#         TASK #2
#         Colourful Number
#             Write a script to display all Colorful Number with 3 digits.
#
#             A number can be declare Colorful Number where all the products of
#             consecutive subsets of digit are different.
#
#             For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3
#             are unique.
#
#         method: for this challenge, we're structurally dealing with the values of
#            individual digits that make up a three digit number and recombining
#            them in different ways. We can extract these digits mathematically, but
#            this being Perl it's easy to treat the candidate number as a string and
#            use split to extract the individual values all at once. Once we have
#            the digits, the particular recombinations studied match a fixed set of
#            variations, which can be enumerated as a list. Mapping this list to hash
#            keys will overwrite duplicate keys, so if we have 6 keys, we have
#            unique values, and the number is determined sufficiantly flashy to be
#            declared colorful. At no point do we ever care as to what the values
#            actually are, we only want to know whether they're unique.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

for (100..999) {
    say $_ if colorful3($_);
}

## ## ## ## ## SUBS:

sub colorful3 {
    my $number = shift;
    my ($hundreds, $tens, $ones) = split //, $number;
    my %products = map { $_ => 1 } ($hundreds, $tens, $ones, $hundreds * $tens,
                                    $tens * $ones, $hundreds * $tens * $ones);
    keys %products == 6 ? 1 : 0;
}
