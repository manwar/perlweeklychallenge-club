#! /opt/local/bin/perl
#
#       stones_and_jewels.pl
#
#        task:Create a script that accepts two strings, let us call it,
#            “stones” and “jewels”. It should print the count of “alphabet”
#            from the string “stones” found in the string “jewels”. For
#            example, if your stones is “chancellor” and “jewels” is
#            “chocolate”, then the script should print “8”. To keep it
#            simple, only A-Z,a-z characters are acceptable. Also make the
#            comparison case sensitive.
#
#        2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my ($stone, $jewel) = @ARGV;
my $jewels = { map { $_, 1 } (split //, $jewel) };
my @gravel = split //, $stone;
my $result = scalar (grep { $jewels->{$_} } @gravel);
say $result;

## this could alternately be done in just two lines:

# my $jewels = { map { $_, 1 } (split //, $ARGV[1]) };
# say scalar (grep { $jewels->{$_} } (split //, $ARGV[0]));


