#!/usr/bin/env perl

# You are given an alphanumeric string.

# Write a script to find the second largest distinct digit in the given
# string. Return -1 if none found.

use Dev::Util::Syntax;
use File::JSON::Slurper qw(read_json);
use Data::Printer;

use Test2::V0;
plan tests => 5;

my $json_ref = read_json( __FILE__ =~ s/pl$/json/r )
    or die "ERROR: could not read test data from json file\n";
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( second_largest_digit( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub second_largest_digit {
    my $str = $_[0]->[0];
    printf qq{Input: %s = "%s"\n}, $input_vars_ref->[0], $str;
    my $result = q{-1};

    my %seen;
    my @uniq = grep { !$seen{ $_ }++ } sort { $b <=> $a } ( $str =~ m/(\d)/g );
    $result = $uniq[1] if exists $uniq[1];

    printf qq{Output: %s\n}, $result;
    return $result;
}
