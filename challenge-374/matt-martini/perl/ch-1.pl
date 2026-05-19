#!/usr/bin/env perl

# You are given a string.

# Write a script to return all possible vowel substrings in the given
# string. A vowel substring is a substring that only consists of vowels
# and has all five vowels present in it.

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

is( count_vowel( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @{ $examples_ref };

sub count_vowel {
    my $str = $_[0]->[0];
    printf qq{ Input: %s = "%s"\n }, $input_vars_ref->[0], $str;
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
    printf qq{Output: ("%s")\n}, join '", "' => @sresults;
    return \@sresults;
}
