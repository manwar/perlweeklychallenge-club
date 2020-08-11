#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-023/
# Task #3
# Write a script to use Random Poems API. This is the easiset API, I have come across so far.
# You don't need API key for this. They have only route to work with (GET).
# https://www.poemist.com/api/v1/randompoems
# The API task is optional but we would love to see your solution.

use strict;
use warnings;

use LWP::Simple qw (get);
use JSON qw( decode_json );
binmode STDOUT, ':encoding(UTF-8)';


my $json = get('https://www.poemist.com/api/v1/randompoems');
die 'No poem for you right now :(' unless defined $json;
my $poems = decode_json( $json );

my $rnd_poem = $poems->[int rand scalar @$poems];
my $heading  = $rnd_poem->{title}.' by '.$rnd_poem->{poet}->{name};
my $line     = q{=} x length $heading;

print sprintf "%s\n%s\n\n%s\n", $heading, $line, $rnd_poem->{content};
