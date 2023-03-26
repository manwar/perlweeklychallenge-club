use strict;
use warnings;
use Test::More;

my %tiles = (
    'A' => [ 1,  8 ],
    'G' => [ 1,  3 ],
    'I' => [ 1,  5 ],
    'S' => [ 1,  7 ],
    'U' => [ 1,  5 ],
    'X' => [ 1,  2 ],
    'Z' => [ 1,  5 ],
    'E' => [ 2,  9 ],
    'J' => [ 2,  3 ],
    'L' => [ 2,  3 ],
    'R' => [ 2,  3 ],
    'V' => [ 2,  3 ],
    'Y' => [ 2,  5 ],
    'F' => [ 3,  3 ],
    'D' => [ 3,  3 ],
    'P' => [ 3,  5 ],
    'W' => [ 3,  5 ],
    'B' => [ 4,  5 ],
    'N' => [ 4,  4 ],
    'T' => [ 5,  5 ],
    'O' => [ 5,  3 ],
    'H' => [ 5,  3 ],
    'M' => [ 5,  4 ],
    'C' => [ 5,  4 ],
    'K' => [ 10, 2 ],
    'Q' => [ 10, 2 ]
);

my @hand = draw_tiles(7);
print "Your hand: @hand\n";
my $word  = get_word(@hand);
my $score = calculate_score($word);
print "Your word: $word\n";
print "Score: $score\n";

sub draw_tiles {
    my ($num_tiles) = @_;
    my @tiles;
    for my $i ( 1 .. $num_tiles ) {
        my $tile = get_random_tile();
        push @tiles, $tile;
    }
    return @tiles;
}

sub get_random_tile {
    my $total_tiles = 0;
    for my $letter ( keys %tiles ) {
        $total_tiles += $tiles{$letter}[1];
    }
    my $rand_num = int( rand($total_tiles) ) + 1;
    for my $letter ( keys %tiles ) {
        if ( $rand_num <= $tiles{$letter}[1] ) {
            $tiles{$letter}[1]--;
            return $letter;
        }
        else {
            $rand_num -= $tiles{$letter}[1];
        }
    }
}

sub get_word {
    my (@hand) = @_;
    print "Enter a word using the tiles in your hand: ";
    chomp( my $word = <STDIN> );
    while ( !is_valid_word( $word, @hand ) ) {
        print "Invalid word. Try again: ";
        chomp( $word = <STDIN> );
    }
    return uc($word);
}

sub is_valid_word {
    my ( $word, @hand ) = @_;
    my %hand_count;
    for my $tile (@hand) {
        $hand_count{$tile}++;
    }

    for my $char ( split //, $word ) {
        if ( !$hand_count{$char}-- ) {
            return 0;
        }
    }

    return length($word) > 0;
}

sub calculate_score {
    my ($word) = @_;
    my $score = 0;

    for my $char ( split //, $word ) {
        if ( exists( $tiles{$char} ) ) {
            $score += $tiles{$char}[0];
        }
        else {
            die "Invalid character in word: $char\n";
        }
    }

    return $score;
}

# Tests
is( is_valid_word( 'CAT', ( 'C', 'A', 'T' ) ), 1 );
is( is_valid_word( 'DOG', ( 'D', 'O', 'G' ) ), 1 );
is( is_valid_word( 'CAT', ( 'C', 'A' ) ),      0 );
is( is_valid_word( 'DOG', ( 'D', 'O' ) ),      0 );

is( calculate_score('CAT'), 8 );
is( calculate_score('DOG'), 6 );

done_testing();
