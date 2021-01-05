#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _sort_word {
    my $word    = shift;
    my @letters = split //, lc $word;
    return join '', sort @letters;
}

sub main {
    # Retrieve a list of words from the command line
    my @words = ( join( ' ', @_ ) =~ /([a-z]+)/ig );

    # Group anagrammed words together
    my %group = ();
    foreach my $word (@words) {
        push @{ $group{ _sort_word($word) } }, $word;
    }

    # Display the result
    my @results = ( values %group );
    foreach my $count ( 0 .. $#results ) {
        my $start = $count == 0         ? '[ ("' : '  ("';
        my $end   = $count == $#results ? '") ]' : '"),';
        say $start, join( '", "', @{ $results[$count] } ), $end;
    }
}

main(@ARGV);
