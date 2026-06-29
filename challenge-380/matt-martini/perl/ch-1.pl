#!/usr/bin/env perl

# You are given a string consisting of English letters.

# Write a script to find the vowel and consonant with maximum frequency.
# Return the sum of two frequencies.

use Dev::Util::Syntax;
use Test2::V0;
plan tests => 5;

use lib '.';
use PWC;
my $json_data = get_json_data();

is( sum_of_frequencies( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for $json_data->{ examples }->@*;

sub sum_of_frequencies {
    my $str = $_[0]->[0];
    print_inputs( $json_data->{ input_vars }, @_ );
    my $result = 0;

    my $vowel_re     = qr{[aeiou]}i;
    my $non_vowel_re = qr{[^aeiou]}i;

    my ( %v_freq, %c_freq );
    $v_freq{ $_ }++ for $str =~ m/$vowel_re/g;
    $c_freq{ $_ }++ for $str =~ m/$non_vowel_re/g;

    $result += ( sort { $b <=> $a } values(%v_freq) )[0];
    $result += ( sort { $b <=> $a } values(%c_freq) )[0];

    print_outputs($result);
    return $result;
}
