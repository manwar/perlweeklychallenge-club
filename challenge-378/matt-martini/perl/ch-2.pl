#!/usr/bin/env perl

# You are given three strings consisting of lower case English letters
# ‘a’ to ‘j’ only. The letter value of a = 0, b = 1, c = 3, etc.

# Write a script to find if sum of first two strings return the
# third string.

use Dev::Util::Syntax;
use File::JSON::Slurper qw(read_json);
use JSON::PP;
use Data::Printer;

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

# Convert any expected output strings "true" and "false"
# as well as JSON Boolean constants true and false
# into Test2::V0::Compare T and F conditions.
for ( @{ $examples_ref } ) {
    for ( @{ $_->{out} } ) {
        if ( /^(?:(true)|(false))$/i || JSON::PP::is_bool( $_ ) ) {
            $_ = $1 ? T : $2 ? F : $_ ? T : F;
        }
    }
}

is( sum_of_words( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub a2d {
    my $str = shift;
    $str =~ tr/abcdefghij/0123456789/;
    return $str;
}

sub sum_of_words {
    my $str1 = $_[0]->[0];
    my $str2 = $_[0]->[1];
    my $str3 = $_[0]->[2];
    printf qq{Input: %s = "%s", %s = "%s", %s = "%s"\n},
        $input_vars_ref->[0], $str1,
        $input_vars_ref->[1], $str2,
        $input_vars_ref->[2], $str3;
    my $result = false;

    if ( a2d($str1) + a2d($str2) == a2d($str3) ) {
        $result = true;
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}
