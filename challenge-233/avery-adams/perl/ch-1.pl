#!/usr/bin/perl
use v5.36;

my @words = @ARGV;
my $matched = 0;
for (my $i = 0; $i <= $#ARGV - 1; $i++) {
    my $start_word = $words[$i];
    my %start_chars = map {$_ => 1} split(//, $start_word);

    for (my $j = $i + 1; $j <= $#ARGV; $j++) {
        my $match_word = $words[$j];
        my %match_chars = map {$_ => 1} split(//, $match_word);

        if (hashes_equal(\%start_chars, \%match_chars)) {
            say $start_word . ", " . $match_word;
            $matched = 1;
        }
    }
}
say 0 unless $matched;

sub hashes_equal ($start_ref, $match_ref) {
    my %start_chars = %{$start_ref};
    my %match_chars = %{$match_ref};

    if (scalar keys %start_chars == scalar keys %match_chars) {
        foreach (keys %start_chars) {
            if (!defined($match_chars{$_})) {
                return;
            }
        }
        return 1;
    } else {
        return;
    }
}