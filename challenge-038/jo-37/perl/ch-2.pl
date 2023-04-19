#!/usr/bin/perl -s

use v5.16;
use autodie;
use warnings;
use List::Util qw(sample sum);
use List::UtilsBy 'max_by';

use constant TILES => 7;
use constant DICT => '/usr/share/dict/words';

our ($help, $dict, $tiles);
$dict ||= DICT;
$tiles ||= TILES;

die <<EOS if $help;
usage: $0 [-dict=DICTIONARY] [-tiles=TILES] [-help]

-dict=DICTIONARY
    read words from DICTIONARY. Default: /usr/share/dict/words
 
-tiles=TILES
    number of tiles taken from heap.

-help
    this help text

EOS


### Input and Output

main: {
    my @selection = selection($tiles);
    say "@selection";
    my ($score, $word) = word_game($dict, @selection);
    say "$word ($score)";
}


### Implementation

sub word_game {
    my $dictfile = shift;
    my @matches;
    open my $dict, '<', $dictfile;
    while (<$dict>) {
        # Prepare read word.
        chomp;
        $_ = uc $_;
        # Build the initial content of a Bracketed Character class.  A
        # single character '!' is added that will never match and
        # prevent the string from becoming empty.
        my $board = '!' . join '', @_;
        # Match the next character of the current word against the
        # character class and remove the matched character.
        $board =~ s/$1// while /\G([$board])/gc;
        # Record the current word if it can be build from the letters on
        # the board.
        push @matches, $_ if /\G$/
    }
    close $dict;
    # Reverse the points-to-letter map into a letter-to-points map.
    my $points = points();
    # Find the highest scored match.
    my $best = max_by {score($points, $_)} @matches;

    # Return score and word.
    (score($points, $best), $best)
}

# Calculate the score of a word.
sub score {
    my $points = shift;
    sum map {$points->{$_}} split //, shift;
}

BEGIN {
    my %tiles = (
        1 => [('A') x 8, ('G') x 3, ('I') x 5, ('S') x 7, ('U') x 5,
            ('X') x 2, ('Z') x 5],
        2 => [('E') x 9, ('J') x 3, ('L') x 3, ('R') x 3, ('V') x 3,
            ('Y') x 5],
        3 => [('F') x 3, ('D') x 3, ('P') x 5, ('W') x 5],
        4 => [('B') x 5, ('N') x 4],
        5 => [('T') x 5, ('O') x 3, ('H') x 3, ('M') x 4, ('C') x 4],
       10 => [('K') x 2, ('Q') x 2]); 

    # Random selection of tiles.
    sub selection {
        my $tiles = shift;
        sample $tiles, map {(@$_)} values %tiles;
    }

    # Reverse the points-to-letter map into a letter-to-points map.
    sub points {
        my %points;
        while (my ($p, $l) = each %tiles) {
            $points{$_} = $p foreach @$l;
        }
        \%points;
    }
}
