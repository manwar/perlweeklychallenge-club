#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _is_ordered {
    my $word = lc shift;
    return if $word !~ /^[a-z]+$/;

    # Order the word by letters
    my $ordered = join '', sort split '', $word;

    return $ordered eq $word;
}

sub main {
    my $file = shift // '/usr/share/dict/words';

    # Define some values
    my $max_length = 0;
    my @words      = ();

    # Open the file for reading
    open( my $fh, '<', $file ) or die "Cannot open file $file: $!";

    while ( my $word = <$fh> ) {
        chomp $word;

        # If the word has all its characters in alphabetical order, either
        #  create a new list if it is longer than the current max_length, or
        #  append it to the list if it is the same.
        if ( _is_ordered($word) ) {
            my $length = length($word);

            if ( $length > $max_length ) {
                $max_length = $length;
                @words      = ($word);
            }
            elsif ( $length == $max_length ) {
                push @words, $word;
            }
        }
    }

    # Disply result
    say "Longest words are: ", join( ', ', @words );
}

main(@ARGV);
