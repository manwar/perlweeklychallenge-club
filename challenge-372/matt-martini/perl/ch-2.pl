#!/usr/bin/env perl

# Write a script to return the length of the largest substring between two
# equal characters excluding the two characters. Return -1 if there is no
# such substring.

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

is( largest_substring( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub largest_substring {
    my $str = $_[0]->[0];
    printf qq{ Input: %s = "%s"\n }, $input_vars_ref->[0], $str;
    my $result = 0;

    my $eq_char_re = qr{(.)(.*)\g1};

    for my $st ( 0 .. length($str) ) {
        pos($str) = $st;
        if ( $str =~ m/$eq_char_re/g ) {
            my $ss = $2;
            if ( length($ss) >= $result ) {
                $result = length($ss);
            }
        }
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}
