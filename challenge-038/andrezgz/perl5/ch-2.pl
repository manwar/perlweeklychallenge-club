#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-038/
# Task #2
# Word Game
# Lets assume we have tiles as listed below, with an alphabet (A..Z) printed on them.
# Each tile has a value, e.g. A (1 point), B (4 points) etc.
# You are allowed to draw 7 tiles from the lot randomly.
# Then try to form a word using the 7 tiles with maximum points altogether.
# You don't have to use all the 7 tiles to make a word.
# You should try to use as many tiles as possible to get the maximum points.
#
# For example, A (x8) means there are 8 tiles with letter A.
# 1 point:   A (x8), G (x3), I (x5), S (x7), U (x5), X (x2), Z (x5)
# 2 points:  E (x9), J (x3), L (x3), R (x3), V (x3), Y (x5)
# 3 points:  F (x3), D (x3), P (x5), W (x5)
# 4 points:  B (x5), N (x4)
# 5 points:  T (x5), O (x3), H (x3), M (x4), C (x4)
# 10 points: K (x2), Q (x2)

use strict;
use warnings;

my $words_file = shift || die "USAGE: $0 <words_file>";

# Points for each tile
my %tile_points = (
    A => 1, G => 1, I => 1, S => 1, U => 1, X => 1, Z => 1,
    E => 2, J => 2, L => 2, R => 2, V => 2, Y => 2,
    F => 3, D => 3, P => 3, W => 3,
    B => 4, N => 4,
    T => 5, O => 5, H => 5, M => 5, C => 5,
    K => 10, Q => 10
);

# Lot of available tiles
my @lot = (
    ('K','Q','X') x 2,
    ('D','F','G','H','J','L','O','R','V') x 3,
    ('C','M','N') x 4,
    ('B','I','P','T','U','W','Y','Z') x 5,
    ('S') x 7,
    ('A') x 8,
    ('E') x 9
);

# 7 randomly drawn tiles from the lot
my %tiles;
++$tiles{ splice @lot, int rand @lot, 1 } for (1..7);

print "Tiles drawn (quantity in parentheses): \n";
print join ', ', map { "$_ (x$tiles{$_})" } sort keys %tiles;
print "\n";

# Determine best word
my $best_word  = '';
my $max_points = 0;

open(my $fh, "<", $words_file) or die "Could not open words file '$words_file': $!";
while( my $w = <$fh> ) {
    chomp $w;
    next unless is_word_formed_by_tiles( uc $w , %tiles );

    my $word_points = 0;
    $word_points += $tile_points{$_} foreach split //, uc $w;

    # best word prioritizes the number of tiles used over the points
    ($best_word, $max_points) = ($w, $word_points) if length($w)   >= length($best_word)
                                                   && $word_points >= $max_points
}
close $fh;

print "Best word: $best_word - $max_points points \n";

#Return 1 if $word is formed by the given tiles
sub is_word_formed_by_tiles {
    my ( $word, %tiles ) = @_;
    foreach my $l (split //,$word ){
        return 0 unless (exists $tiles{ $l } && $tiles{ $l } > 0);
        $tiles{ $l }--;
    }
    return 1;
}

__END__

./ch-2.pl words.txt
Tiles drawn (quantity in parentheses):
A (x1), B (x1), E (x2), H (x1), N (x1), T (x1)
Best word: beneath - 23 points
