#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(all);

sub word_to_hash ($word) {
    my %hash = ();
    foreach my $letter ( split //, lc $word ) {
        $hash{$letter} = 1;
    }
    return \%hash;
}

sub main (@words) {
    # Turns the words into a list of hashes, and take off the first word
    my @set_list   = ( map { word_to_hash($_) } @words );
    my $first_word = shift(@set_list);
    my @letters    = ();

    # Go through each letter in the first word
    foreach my $letter ( sort keys(%$first_word) ) {
        # And checks it is used in all other words
        if (    'a' le $letter
            and $letter le 'z'
            and all { exists $_->{$letter} } @set_list )
        {
            # It is! Add it to the letters list
            push @letters, $letter;
        }
    }

    say join( ', ', @letters );

}

main(@ARGV);
