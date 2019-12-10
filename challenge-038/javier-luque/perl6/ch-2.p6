# Test: perl6 ch-2.p6
use v6.d;

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

# Box configurations
sub MAIN () {
    # Load the dictionary
    load-words('/usr/share/dict/words');

    # Grab 7 tiles
    my @tiles = get-tiles(7);
    say 'Picked tiles: ' ~ @tiles;

    # Find the word with the most points
    my ($word, $score) = find-best-word(@tiles);
    say 'Best word: ' ~ $word ~
        ' with score: ' ~ $score;
}

# Find the best word
sub find-best-word(@tiles) {
    my $top_score = 0;
    my $top_word;

    my @combos = @tiles.combinations: 1..7;
    for @combos -> $combo {
        for $combo.permutations -> $perms {
            my $word = $perms.join;

            if %valid_words.{$word} {
                my $score = calculate-score($word);

                # If this is the best word store it
                if ($score > $top_score) {
                    $top_score = $score;
                    $top_word  = $word;
                }
            }
        };
    }

    return $top_word, $top_score;
}

# Calculate score
sub calculate-score(Str $word) {
    my $score = 0;

    for $word.comb -> $letter {
        $score += %tiles_metadata.{$letter}.{'points'};
    }

    return $score;
}

# Get tiles
sub get-tiles(Int $number_of_tiles) {
    my @tileset;

    # Generate the set of tiles
    for %tiles_metadata.keys() -> $key {
        for 1 .. %tiles_metadata.{$key}.{"amount"} -> $i {
            @tileset.push($key);
        }
    }

    return @tileset.pick($number_of_tiles)
}

# Load the dictionary into memory
sub load-words(Str $filename) {
    for $filename.IO.lines -> $line {
        %valid_words{$line.uc} = 1;
    }
}
