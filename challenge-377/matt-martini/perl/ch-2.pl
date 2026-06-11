#!/usr/bin/env perl

# You are given an array of strings.

# Write a script to find if the two strings (str1, str2) in the given
# array such that str1 is prefix and suffix of str2. Return the total
# count of such pairs.

use Dev::Util::Syntax;
use File::JSON::Slurper      qw(read_json);
use Algorithm::Combinatorics qw(combinations);

use Test2::V0;
plan tests => 6;

my $json_ref = read_json( __FILE__ =~ s/pl$/json/r )
    or die "ERROR: could not read test data from json file\n";
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( prefix_suffix( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub pre_suf {
    my ( $str1, $str2 ) = @_;

    return (    ( $str1 eq substr( $str2, 0, length $str1 ) )
             && ( $str1 eq substr( $str2, -length $str1, length $str1 ) ) );
}

sub prefix_suffix {
    my @array = $_[0]->@*;
    printf qq{Input: %s = ("%s")\n}, $input_vars_ref->[0], join '", "' => @array;
    my $result = 0;

    my $iter = combinations( \@array, 2 );
    while ( my $com = $iter->next ) {
        if ( pre_suf( $com->@* ) ) {
            $result++;
        }
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}
