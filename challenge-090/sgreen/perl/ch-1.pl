#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $string = shift;

    # Sanity check the input
    die "You must enter the DNA sequence\n" unless $string;
    die "Unexpected character in the DNA sequence\n"
      unless $string =~ /^[TACG]+$/;

    # Count the nucleobases and display them
    my %count = ();
    say 'Nucleobases count';
    foreach my $nucleobase ( split //, $string ) {
        ++$count{$nucleobase};
    }
    foreach my $nucleobase (qw(T A G C)) {
        say $nucleobase, ': ', $count{$nucleobase} // 0;
    }

    # Display the complementary sequence
    $string =~ tr/TAGC/ATCG/;
    say "\nComplementary sequence is '$string'";
}

main(@ARGV);
