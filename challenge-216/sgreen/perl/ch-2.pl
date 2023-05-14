#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics qw(variations_with_repetition);
use List::Util               qw(any max sum);

sub get_frequency ($word) {
    my %freq = ();
    foreach my $letter ( split //, $word ) {
        if ( 'a' le $letter and $letter le 'z' ) {
            ++$freq{$letter};
        }
    }

    return %freq;
}

sub main (@words) {
    # The last value is the word we are matching
    my $target_word = pop(@words);
    my %target_freq = get_frequency($target_word);

    # Lets check that a solution is possible
    my $all_letters = join( '', @words );
    if ( any { index( $all_letters, $_ ) == -1 } split( //, $target_word ) ) {
        # The letter doesn't exist in the words, so no solution is possible
        say 0;
        return;
    }

    # What is the highest frequency
    my $highest      = max( values(%target_freq) );
    my $word_count   = scalar(@words);
    my $min_stickers = 'Inf';

    my $iter = variations_with_repetition( [ 0 .. $highest ], $word_count );
  W: while ( my $freq = $iter->next() ) {
        # This solution won't be better, so skip it
        next if sum(@$freq) >= $min_stickers;

        # Combine all the words with the defined frequency
        my $sticker_letters =
          join( '', map { $words[$_] x $freq->[$_] } ( 0 .. $#words ) );
        my %sticker_freq = get_frequency($sticker_letters);

        foreach my $letter ( keys %target_freq ) {
            if ( not exists $sticker_freq{$letter}
                or $sticker_freq{$letter} < $target_freq{$letter} )
            {
                # Either a letter is missing, or doesn't occur enough times
                next W;
            }
        }

        # We have a new solution with fewer letters
        $min_stickers = sum(@$freq);
    }

    say $min_stickers;
}

main(@ARGV);