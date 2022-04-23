#!/usr/bin/env perl
#
# ch-2.pl - Pangram generator
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

use List::Util    qw< uniq >;
use File::Slurper qw< read_lines >;
use Getopt::Long;

no warnings 'uninitialized';

my %o = (dict => '../../../data/dictionary.txt', min => 4);
GetOptions(\%o, qw< dict=s min=i >)
    or die "Usage: $0 [--dict=path/to/dict.txt]\n";

my @words   = grep { $o{min} < length } read_lines($o{dict});

my @pangram = pangram(@words);

printf "Pangram is %d words / %d letters long \n\n%s\n",
    scalar(@pangram), length("@pangram"), "@pangram";

# Greedy pangram generator. At every step, looks for the word that
# maximizes new_letters * 2 - word_length.
sub pangram {
    my @pangram;  # Pangram gets built here
    my %has;

    # Trade some space for time
    my %words = map { $_ => [ uniq split // ] } @_;

    while (keys %has < 26) {
        my %best = (word => undef, score => -26);

        for my $word (keys %words) {
            my $new = grep { !$has{$_} } @{$words{$word}};
            if ($new == 0) {
                delete $words{$word};
                next;
            }

            my $score = $new * 2 - length;
            %best = (word => $word, score => $score)
                if $score > $best{score};
        }

        # Put the best word in the @pangram
        push @pangram, $best{word};
        $has{$_} = 1 for @{$words{$best{word}}};
    }

    @pangram;
}
