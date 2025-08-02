#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub calculate_frequency ($s) {
    # Calculate the frequency of each letter
    my %freq = ();
    foreach my $s ( split //, $s ) {
        $freq{$s}++;
    }
    return \%freq;
}

sub main (@str_list) {
    # The first value is the str to match
    my $str = shift(@str_list);

    # Calculate the frequency of letters in the string after converting to lower
    #  case and remove non ASCII characters
    $str = lc $str;
    $str =~ s/[^a-z]//g;
    my $freq = calculate_frequency($str);

    # Sort the list by length (shortest first)
    @str_list = sort { length($a) <=> length($b) } @str_list;
  WORD: foreach my $word (@str_list) {
        # Calculate the frequency of letters in this word
        my $word_freq = calculate_frequency( lc $word );

        foreach my $letter ( keys %$freq ) {
            # Check that this letter appear in word at least count times
            if ( ( $word_freq->{$letter} // 0 ) < $freq->{$letter} ) {
                next WORD;
            }
        }

        # We have a solution
        say $word;
        return;
    }

    say 'No solution found!';
}

main(@ARGV);