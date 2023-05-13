#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 216 Task 2: Word Stickers
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use Data::Dump qw( pp );
use List::Util qw( min );

sub word_stickers {
    my ( $stickers, $word ) = @_;
    say "word_stickers( ", pp( $stickers, $word ), " )";

    # Keep count of how many of each letter we need.
    my %needed;
    $needed{$_}++
        for $word =~ /./g;

    # For any letter, mark which stickers give that letter.
    # If we need a certain letter, we then can check whether
    # - the letter is still available from a sticker we already took
    #   (marked in %available, see further below),
    # - get one of the stickers that give us that letter
    #   (marked in @{$letter_stickers{<letter>}}).
    my %letter_stickers;
    for my $sticker ( @$stickers ) {
        # Make sure we add the sticker only once, even if the same letter
        # occurs several times on the sticker.
        my %sticker_letters = map { ( $_ => 1 ) } $sticker =~ /./g;
        push @{$letter_stickers{$_}}, $sticker
            for keys %sticker_letters;
    }
    say "letter stickers:\n", pp( \%letter_stickers );
    say "needed letters:\n", pp( \%needed );

    # Keep count of how many of each letter we have available from stickers.
    my %available;
    my $n_stickers_used = 0;
    while ( %needed ) {
        my $resolved_a_letter = 0;
        for my $letter ( sort keys %needed ) {
            say "trying to resolve letter '$letter'";
            # Get stickers if needed.
            if ( ( $available{$letter} || 0 ) < $needed{$letter} ) {
                # Get stickers for this letter if there is only one sticker type
                # that gives us this letter. If not , we wait with this letter.
                unless ( $letter_stickers{$letter} ) {
                    say "no sticker for letter '$letter'";
                    return 0;
                }
                if ( @{ $letter_stickers{$letter} // [] } == 1 ) {
                    my $sticker = $letter_stickers{$letter}[0];
                    # Get as many stickers of this type as we need for this
                    # letter, adding all sticker letters to the available
                    # letters.
                    # Note that the same letter can appear several times on the
                    # sticker, so add stickers one by one.
                    do {
                        say "adding sticker '$sticker' to available letters";
                        $available{$_}++
                            for $sticker =~ /./g;
                        ++$n_stickers_used;
                    } until $available{$letter}
                        >= $needed{$letter};
                }
                say "available letters now: ",
                    join " ",
                        map "$_:$available{$_}",
                            sort keys %available;
            }

            if ( $available{$letter} && $available{$letter} >= $needed{$letter} ) {
                # Use available letters.
                say "using $needed{$letter} available letters '$letter'";
                $available{$letter} -= $needed{$letter};
                delete $available{$letter}
                    if $available{$letter} == 0;
                delete $needed{$letter};
                $resolved_a_letter = 1;
            }
        }
        unless ( $resolved_a_letter ) {
            # For the remaining letters, we need to decide which of several
            # possible stickers we want to take.
            # This optimizing process is NOT YET IMPLEMENTED.
            say "Giving up on this one for now.";
            return 0;
        }
    }
    return $n_stickers_used;
}


use lib '.';
use TestExtractor;
run_tests();


__DATA__

Test 1:
Input: @stickers = ('bubble', 'aaron'), $word = 'bubba'
Output: 2
Watch out for the same letter appearing several times on the same sticker.
