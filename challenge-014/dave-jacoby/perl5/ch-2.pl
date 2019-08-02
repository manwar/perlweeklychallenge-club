#!/usr/bin/env perl

use feature qw{ say };
use strict;
use warnings;

# Using only the official postal (2-letter) abbreviations for the
# 50 U.S. states, write a script to find the longest English word
# you can spell? Here is the list of U.S. states abbreviations as
# per wikipedia page. This challenge was proposed by team member
# Neil Bowers.

# using the %states hash makes for easy testing
my %states = map { $_ => 1 } qw{
    AL AK AZ AR CA CO CT DE FL GA
    HI ID IL IN IA KS KY LA ME MD
    MA MI MN MS MO MT NE NV NH NJ
    NM NY NC ND OH OK OR PA RI SC
    CD TN TX UT VT VA WA WV WI WY
};

# more universally available than my go-to dictionary DB
my @words;
if ( open my $fh, '<', '/usr/share/dict/words' ) {
    @words = map { chomp; uc $_ } <$fh>;
}

my $longest = '';
FOR: for my $word (@words) {
    my @word = $word =~ /(\w{2})/g;

    # there are apostrophes and unicode in that list
    # this ensures that what we're looking at is valid.
    my $join = join '', @word;
    next unless $join eq $word;

    # we check every letter pair and determine if it's in
    # the states hash. we have labelled the outside for loop
    # as FOR, so we can `next` on the outer loop, not just the
    # inner loop.
    for my $wo ( @word ) {
        my $n = $states{$wo} ? 1 : 0;
        next FOR unless $n;
    }    

    # words that are not entirely made out of state abbreviations
    # will not reach this point. And this will ignore words of 
    # identical size to the found longest, but I know they don't
    # exist.
    $longest = $word if length $longest < length $word;
}
say $longest;

__DATA__

CACOGALACTIA

    noun In pathology, a bad condition of the milk.

