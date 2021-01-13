#!/usr/bin/env perl6
use v6;

# run as <script> <address to validate>
# valid addresses to try (https://perlweeklychallenge.org/blog/perl-weekly-challenge-016/):
# 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
# 3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy

use HTTP::Tiny;

my $URL='http://www.lenschulwitz.com/base58er';
my $address=@*ARGS[0];

my $resp=HTTP::Tiny.new;
say .<content>.decode with $resp.request(
    'POST',
    $URL,
    content => {
	address => $address,
	b58action => 'validate'
    });
