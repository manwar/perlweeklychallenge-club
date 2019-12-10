#!/usr/bin/env perl

# ch-2.pl - Scrabble word finder
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use autodie;
use strict;
use utf8;
no warnings 'uninitialized';

use File::Slurper qw< read_lines >;
use List::Util    qw< shuffle uniq sum max >;
use Memoize;

memoize 'word_score';

# I'm not checking in an entire (probably copyrighted) dictionary,
# so please supply your own. :-)
my $dict = shift // die "Usage: $0 /path/to/dict.txt";
my %dict = map { uc, 1 } read_lines $dict;

# Point values for each tile, as given in the challenge description:
my %val;
$val{$_} =  1 for qw< A G I S U X Z >;
$val{$_} =  2 for qw< E J L R V Y   >;
$val{$_} =  3 for qw< F D P W       >;
$val{$_} =  4 for qw< B N           >;
$val{$_} =  5 for qw< T O H M C     >;
$val{$_} = 10 for qw< K Q           >;

# Tile counts in bag. Each letter is repeated the specified number of times
# We shuffle with List::Util's shuffle(), but see perlfaq4 for Fisher-Yates
my @bag = shuffle map { my ($l, $count) = split //; ($l) x $count }
      qw< A8 G3 I5 S7 U5 X2 Z5
          E9 J3 L3 R3 V3 Y5
          F3 D3 P5 W5
          B5 N4
          T5 O3 H3 M4 C4
          K2 Q2 >;

my @seven = @bag[0..6]; # My first one was S N S R H Z X  :-(

my %best = best_word(@seven);

say "Letters: @seven. Best word: $best{word}, Score: $best{score}";


# Maximize word score of @seven letters and return the word and score.
#
# There are N! permutations of N letters, so we check each of those
# against the dict hash, giving us O(N!) time, which runs in about
# 2.5 microseconds on my slow VM. (7! = 5040 permutations). Reading
# the dictionary from disk is 4-5 orders of magnitude slower.
sub best_word {
    my %best = (word => '', score => 0); # Best word and score

    my $check;
    $check = sub {
        my ($frag, $tail) = @_;

        if ( $dict{$frag} ) {
            my $score = word_score($frag);
            %best = (word => $frag, score => $score) if $score > $best{score};
        }

        $check->($frag . $_, $tail =~ s/$_//r) for uniq sort split //, $tail;
    };

    $check->( '', join('', @_) );

    %best;
}

# Calculate a word score. Memoized, so it is computed at most once.
sub word_score { sum map { $val{$_} } split '', shift }
