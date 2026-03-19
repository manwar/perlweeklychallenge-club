#!/usr/bin/env perl

# You are given a sentence.

# Write a script to split the given sentence into space-separated
# tokens and count how many are valid words. A token is valid if:
#     it contains no digits,
#     has at most one hyphen surrounded by lowercase letters,
#     and at most one punctuation mark (!, ., ,) appearing only at the end.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub valid_token_counter {
    my $str    = shift;
    my $result = 0;
    printf qq{ Input: $str = "%s"\n }, $str;

    my @words = split /\s+/, $str;
    WORD:
    foreach my $word (@words) {
        my $hyphen_count = () = $word =~ m/[-]/g;
        my $punct_count  = () = $word =~ m/[!,.]/g;

        if (     ( $word =~ m/\d/ )
              || ( $hyphen_count > 1 )
              || ( $word =~ m/(?:^-)|(?:-$)/ )
              || ( $punct_count > 1 )
              || ( $word =~ m/[!.,][^!.,]+$/ ) )
        {
            next WORD;
        }
        $result++;
    }

    printf qq{Output: %d\n}, $result;
    return $result;
}

my @examples = (
                 { in => "cat and dog", out => 3, name => 'example 1' },
                 { in => "a-b c! d,e",  out => 2, name => 'example 2' },
                 {  in   => "hello-world! this is fun",
                    out  => 4,
                    name => 'example 3'
                 },
                 { in => "ab- cd-ef gh- ij!", out => 2, name => 'example 4' },
                 { in => "wow! a-b-c nice.",  out => 2, name => 'example 5' },
               );

is( valid_token_counter( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;

