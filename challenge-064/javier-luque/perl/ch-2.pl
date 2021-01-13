#!/usr/bin/perl
# Test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;

my $S = "perlweeklychallenge";
my @W = ("weekly", "challenge", "perl");
say $S;
say check_word($S, \@W);

my $S2 = "perlandraku";
my @W2 = ("python", "ruby", "haskell");
say "\n" . $S2;
say check_word($S2, \@W2);


sub check_word {
    my ($string, $words) = @_;

    my $word_re = join '|', @$words;
    my @split_words =
    	grep { $_  }
    	split (/($word_re)/, $string);

    return scalar(@split_words) == scalar(@$words) ?
    	join ' ', @split_words : 0;
}
