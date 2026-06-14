#!/usr/bin/env perl

# You are given a string.

# Write a script to find whether any substring of length 2 is also present
# in the reverse of the given string.

use Dev::Util::Syntax;
use File::JSON::Slurper qw(read_json);
use JSON::PP;

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

is( reverse_existence( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub reverse_existence {
    my $str = $_[0]->[0];
    printf qq{Input: %s = "%s"\n}, $input_vars_ref->[0], $str;
    my $result = JSON::PP::false;

    my @substrs;
    $str =~ m{ # get all two char substrings
                (..)
                (?{push @substrs, $&})
                (?!)
            }x;

    my $rev = reverse $str;

    for (@substrs) {
        if ( index( $rev, $_ ) != -1 ) {
            $result = JSON::PP::true;
            last;
        }
    }

    printf qq{Output: %s\n}, $result ? "true" : "false";
    return $result;
}
