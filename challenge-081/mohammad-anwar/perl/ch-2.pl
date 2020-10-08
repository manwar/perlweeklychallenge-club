#!/usr/bin/perl

#
# Perl Weekly Challenge - 081
#
# Task #2: Frequency Count
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-081
#

use strict;
use warnings;

frequency_count(fetch_words($ARGV[0]));

#
#
# SUBROUTINES

sub fetch_words {
    my ($file) = @_;

    open(my $fh, "<:encoding(UTF-8)", $file)
        or die "ERROR: Unable to open $file: $!\n";

    my %words = ();
    while (my $line = <$fh>) {
        chomp $line;
        $line =~ s/\.//g;
        $line =~ s/\"//g;
        $line =~ s/\(//g;
        $line =~ s/\)//g;
        $line =~ s/\,//g;
        $line =~ s/\'s//g;
        $line =~ s/\-\-/ /g;
        foreach my $word (split /\s/, $line) {
            $words{$word} += 1;
        }
    }

    close($fh);

    return \%words;
}

sub frequency_count {
    my ($words) = @_;

    my %frequency = ();
    foreach my $word (keys %$words) {
        $frequency{$words->{$word}} .= " " . $word;
    }

    foreach my $count (sort { $a <=> $b } keys %frequency) {
        my @words = split / /, $frequency{$count};
        printf("%d%s\n", $count, join(" ", sort @words));
    }
}
