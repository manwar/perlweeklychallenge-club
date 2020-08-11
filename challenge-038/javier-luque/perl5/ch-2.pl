#!/usr/bin/perl
# Test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;
use Algorithm::Combinatorics qw(variations);
use List::Util qw(shuffle);

# Store valid words
our %valid_words;

# Tiles metadata
our %tiles_metadata =  (
    A => { points => 1,  amount => 8 },
    B => { points => 4,  amount => 5 },
    C => { points => 5,  amount => 4 },
    D => { points => 3,  amount => 3 },
    E => { points => 2,  amount => 9 },
    F => { points => 3,  amount => 3 },
    G => { points => 1,  amount => 3 },
    H => { points => 5,  amount => 3 },
    I => { points => 1,  amount => 5 },
    J => { points => 2,  amount => 3 },
    K => { points => 10, amount => 2 },
    L => { points => 2,  amount => 3 },
    M => { points => 5,  amount => 4 },
    N => { points => 4,  amount => 4 },
    O => { points => 5,  amount => 3 },
    P => { points => 3,  amount => 5 },
    Q => { points => 10, amount => 2 },
    R => { points => 2,  amount => 3 },
    S => { points => 1,  amount => 7 },
    T => { points => 5,  amount => 5 },
    U => { points => 1, amount  => 5 },
    V => { points => 2,  amount => 3 },
    W => { points => 3,  amount => 5 },
    X => { points => 1,  amount => 2 },
    Y => { points => 2,  amount => 5 },
    Z => { points => 1,  amount => 5 },
);

# Load the dictionary
load_words('/usr/share/dict/words');

# Grab 7 times
my @tiles = get_tiles(7);
say 'Picked tiles: ' . join ', ', @tiles;

# Find the word with the most points
my ($word, $score) = find_best_word(\@tiles);
say 'Best word: ' . $word .
    ' with score: ' . $score;

# Load the dictionary into memory
sub load_words {
    my $filename = shift;

    open(my $fh, '<:encoding(UTF-8)', $filename) || die "$@";
    while (my $row = <$fh>) {
        chomp $row;
        $valid_words{uc($row)} = 1;
    }
}

# Get tiles
sub get_tiles {
    my $no_tiles = shift;

    # Generate the set of tiles
    my @tileset;
    for my $key (keys %tiles_metadata) {
        for my $i (1 .. $tiles_metadata{$key}->{amount}) {
            push @tileset, $key;
        }
    }

    # Get Seven tiles
    my @shuffled_indexes = shuffle(0..$#tileset);
    my @my_tiles =
        @tileset[
            @shuffled_indexes[ 0 .. $no_tiles -1 ]
        ];
    return @my_tiles;
}

# Find the best word
sub find_best_word {
    my $tiles_ref = shift;
    my $top_score = 0;
    my $top_word;

    # Generate the possible combinations
    for my $i (1..7) {
        my $iter = variations($tiles_ref,$i);

        # Loop through each variation
        while (my $v = $iter->next) {
            my $word = join '', @{$v};
            if ($valid_words{$word}) {
                my $score = calculate_score($v);

                # If this is the best word store it
                if ($score > $top_score) {
                    $top_score = $score;
                    $top_word  = $word;
                }
            }
        }
    }

    return $top_word, $top_score;
}

# Calculate score
sub calculate_score {
    my $word_ref = shift;
    my $score = 0;

    for my $letter (@${word_ref}) {
        $score += $tiles_metadata{$letter}->{points};
    }

    return $score;
}
