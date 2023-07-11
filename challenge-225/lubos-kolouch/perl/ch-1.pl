#!/usr/bin/perl
use strict;
use warnings;

sub max_words {
    my @list      = @_;
    my $max_count = 0;

    foreach my $sentence (@list) {
        my $word_count = scalar( split( /\s+/, $sentence ) );
        $max_count = $word_count if $word_count > $max_count;
    }

    return $max_count;
}

# testing
my @list = (
    "Perl and Raku belong to the same family.",
    "I love Perl.",
    "The Perl and Raku Conference."
);

print max_words(@list), "\n";    # should print 8
