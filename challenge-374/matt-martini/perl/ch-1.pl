#!/usr/bin/env perl

# You are given a string.

# Write a script to return all possible vowel substrings in the given
# string. A vowel substring is a substring that only consists of vowels
# and has all five vowels present in it.

use Dev::Util::Syntax;
use Test2::V0;
plan tests => 5;

use lib '.';
use PWC;
my $json_data = get_json_data();

is( count_vowel( $_->{ in } ), $_->{ out }, $_->{ name } )
    for $json_data->{examples}->@*;

sub count_vowel {
    my $str = $_[0]->[0];
    print_inputs($json_data->{input_vars}, @_);
    my @results;

    my $vowel_re      = qr{[aeiou]}i;
    my $non_vowel_re  = qr{[^aeiou]}i;
    my $all_vowel_re  = qr/(?=.*a)(?=.*e)(?=.*i)(?=.*o)(?=.*u)$vowel_re{5,}/i;

    my @str = split $non_vowel_re, $str;
    foreach my $st (@str) {
        my @vstr;
        $st =~ m{
               ($all_vowel_re)
               (?{push @vstr, $&})
               (?!)
            }x;
        push @results, grep { $_ =~ $all_vowel_re } @vstr;
    }

    my @sresults = sort @results;
    print_outputs(\@sresults);
    return \@sresults;
}
