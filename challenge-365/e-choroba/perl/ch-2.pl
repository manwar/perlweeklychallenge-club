#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub valid_token_counter($str) {
    my @tokens = grep ! /[0-9]/ && ! /[,?!.]./ && ! /-.*-|^-|-$/,
                 split ' ', $str;
    return scalar @tokens
}

use Test::More tests => 5 + 2;

is valid_token_counter('cat and dog'), 3, 'Example 1';
is valid_token_counter('a-b c! d,e'), 2, 'Example 2';
is valid_token_counter('hello-world! this is fun'), 4, 'Example 3';
is valid_token_counter('ab- cd-ef gh- ij!'), 2, 'Example 4';
is valid_token_counter('wow! a-b-c nice.'), 2, 'Example 5';

is valid_token_counter(""), 0, 'Empty';
is valid_token_counter(' a- -b c-d-e ?f g1h '), 0, 'None';
