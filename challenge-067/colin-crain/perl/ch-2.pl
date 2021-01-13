#! /opt/local/bin/perl
#
#       hooked_on_phonics.pl
#
#         TASK #2 › Letter Phone
#         Submitted by: Mohammad S Anwar
#
#             You are given a digit string $S. Write a script to print all
#             possible letter combinations that the given digit string could
#             represent.
#
#             Letter Phone
#                 2  -->   ABC
#                 3  -->   DEF
#                 4  -->   GHI
#                 5  -->   JKL
#                 6  -->   MNO
#                 7  -->   PQRS
#                 8  -->   TUV
#                 9  -->   WXYZ
#
#
#             Example:
#               Input: $S = '35'
#
#               Output: ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"].
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $input = $ARGV[0] // '5273';
$input =~ s/\W//g;       ## tolerate phone number formats, strip punct chars
($input =~ /[^2-9]/) and
    die "only numbers between 2 through 9 can be alphabetized\n";

my @digits = split //, $input;

my %encode = (  2  =>  ["a", "b", "c"],
                3  =>  ["d", "e", "f"],
                4  =>  ["g", "h", "i"],
                5  =>  ["j", "k", "l"],
                6  =>  ["m", "n", "o"],
                7  =>  ["p", "q", "r", "s"],
                8  =>  ["t", "u", "v"],
                9  =>  ["w", "x", "y", "z"]  );
my $list = $encode{(shift @digits)};

my @list = make_strings(\%encode, \@digits, $list)->@*;
say $_ for @list;

## ## ## ## ## SUBS:

sub make_strings {
    my ($encode, $digits, $list) = @_;
    return $list unless $digits->@*;

    my @newlist = ();
    my $digit = shift $digits->@*;
    for my $str ( $list->@* ) {
        for ( $encode->{$digit}->@* ) {
            push @newlist, $str . $_;
        }
    }
    return make_strings( $encode, $digits, \@newlist);
}
