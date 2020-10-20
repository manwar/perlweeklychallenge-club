#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

sub main {
    my $string = shift;

    my ($middle_words) = ( $string =~ /^\s*\S+?\s+(.*)\s+\S+\s*$/ );
    die "You must enter a string with at least three words\n"
      unless $middle_words;

    # Remove ant whitespace
    $middle_words =~ s/\s//g;
    say length $middle_words;
}

main(@ARGV);
