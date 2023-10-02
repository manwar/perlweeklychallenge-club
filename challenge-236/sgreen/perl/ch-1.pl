#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'min';

sub main (@notes) {
    # Store what is in the wallet, key is the dollar value, value is the
    #  number of notes we have
    my %wallet = ();

  C: foreach my $customer_note (@notes) {
        # Add the amount the person has given us
        $wallet{$customer_note}++;

        if ( $customer_note == 5 ) {
            # No change required :)
            next;
        }

        my $change = $customer_note - 5;

        # We try the bigger notes first
        foreach my $wallet_note ( sort { $b <=> $a } keys %wallet ) {
            my $note_count =
              min( $wallet{$wallet_note}, int( $change / $wallet_note ) );
            if ( $note_count > 0 ) {
                # Take the note from the wallet, and reduce the change still
                #  to give
                $wallet{$wallet_note} -= $note_count;
                $change -= $wallet_note * $note_count;

                if ( $change == 0 ) {
                    next C;
                }
            }
        }

        say 'false';
        return;
    }

    say 'true';
}

main(@ARGV);