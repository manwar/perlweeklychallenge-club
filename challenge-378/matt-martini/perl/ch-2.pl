#!/usr/bin/env perl

# You are given three strings consisting of lower case English letters
# ‘a’ to ‘j’ only. The letter value of a = 0, b = 1, c = 3, etc.

# Write a script to find if sum of first two strings return the
# third string.

use Dev::Util::Syntax;
use Test2::V0;
plan tests => 6;

use lib '.';
use PWC;
my $json_data = get_json_data();

is( sum_of_words( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for $json_data->{examples}->@*;

sub a2d {
    my $str = shift;
    $str =~ tr/a-j/0-9/;
    return $str;
}

sub sum_of_words {
    my $str1 = $_[0]->[0];
    my $str2 = $_[0]->[1];
    my $str3 = $_[0]->[2];
    print_inputs($json_data->{input_vars}, @_);
    my $result = false;

    if ( a2d($str1) + a2d($str2) == a2d($str3) ) {
        $result = true;
    }

    print_outputs($result);
    return $result;
}
