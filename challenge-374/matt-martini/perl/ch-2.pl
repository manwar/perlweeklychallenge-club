#!/usr/bin/env perl

# You are given a string containing 0-9 digits only.

# Write a script to return the largest number with all digits the same in
# the given string. use 5.018; use strict; use warnings; use
# File::JSON::Slurper qw(read_json); use Data::Printer;

use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);

use Test2::V0;
plan tests => 5;

my $json_ref       = read_json( __FILE__ =~ s/pl$/json/r );
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is(
    largest_same_digits_number( $_->{ in } ),
    $_->{ out }->[0],
    $_->{ name }
  )
    for @{ $examples_ref };

sub largest_same_digits_number {
    my $str = $_[0]->[0];
    printf qq{Input: %s = "%s"\n}, $input_vars_ref->[0], $str;
    my $result = q{0};

    my $same_digit_re = qr{((\d)\g2*)};

    while ( $str =~ m/$same_digit_re/g ) {
        $result = $1 if ( $result < $1 );
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}
