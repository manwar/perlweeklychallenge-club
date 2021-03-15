#!/usr/bin/perl

# Challenge 076
#
# TASK #2 › Word Search
# Submitted by: Neil Bowers
# Reviewed by: Ryan Thompson
# Write a script that takes two file names. The first file would contain word search grid as shown below. The second file contains list of words, one word per line. You could even use local dictionary file.
#
# Print out a list of all words seen on the grid, looking both orthogonally and diagonally, backwards as well as forwards.
#
# Search Grid
# B I D E M I A T S U C C O R S T
# L D E G G I W Q H O D E E H D P
# U S E I R U B U T E A S L A G U
# N G N I Z I L A I C O S C N U D
# T G M I D S T S A R A R E I F G
# S R E N M D C H A S I V E E L I
# S C S H A E U E B R O A D M T E
# H W O V L P E D D L A I U L S S
# R Y O N L A S F C S T A O G O T
# I G U S S R R U G O V A R Y O C
# N R G P A T N A N G I L A M O O
# E I H A C E I V I R U S E S E D
# S E T S U D T T G A R L I C N H
# H V R M X L W I U M S N S O T B
# A E A O F I L C H T O D C A E U
# Z S C D F E C A A I I R L N R F
# A R I I A N Y U T O O O U T P F
# R S E C I S N A B O S C N E R A
# D R S M P C U U N E L T E S I L
# Output
# Found 54 words of length 5 or more when checked against the local dictionary. You may or may not get the same result but that is fine.
#
# aimed, align, antes, argos, arose, ashed, blunt, blunts, broad, buries, clove, cloven, constitution, constitutions, croon, depart, departed, enter, filch, garlic, goats, grieve, grieves, hazard, liens, malign, malignant, malls, margo, midst, ought, ovary, parted, patna, pudgiest, quash, quashed, raped, ruses, shrine, shrines, social, socializing, spasm, spasmodic, succor, succors, theorem, theorems, traci, tracie, virus, viruses, wigged

use strict;
use warnings;
use 5.030;
use Path::Tiny;

@ARGV==2 or die "Usage: ch-2.pl grid words\n";
my($grid_file, $words_file) = @ARGV;

my @grid = parse_grid($grid_file);
my %words = grid_words(5, \@grid);
my @found = find_dict($words_file, \%words);

say join(", ", sort @found);


# parse grid file, return matrix m x n or letters
sub parse_grid {
    my($file) = @_;
    my @grid = path($file)->lines;
    for (@grid) {
        s/\s+//g;
        $_ = [split //, $_];
    }
    return @grid;
}

# extract all possible words with the given minimum length
# from the grid in all 8 directions
sub grid_words {
    my($min_len, $grid) = @_;
    my %words;
    for my $r0 (0 .. $#{$grid}) {
        for my $c0 (0 .. $#{$grid->[0]}) {
            for my $dr (-1 .. 1) {
                for my $dc (-1 .. 1) {
                    if (!($dr==0 && $dc==0)) {
                        my $word = "";
                        for (my $len = 0; 1; $len++) {
                            my($r, $c) = ($r0+$len*$dr, $c0+$len*$dc);
                            last if $r < 0 || $r > $#{$grid} || $c < 0 || $c > $#{$grid->[0]};
                            $word .= $grid->[$r][$c];
                            if (length($word) >= $min_len) {
                                $words{lc($word)} = 1;
                            }
                        }
                    }
                }
            }
        }
    }
    return %words;
}

# return all wards from dictionary that exist in the given hash
sub find_dict {
    my($dict, $words) = @_;
    my @found;
    open(my $fh, "<", $dict) or die "$dict: $!\n";
    while (<$fh>) {
        chomp;
        push @found, $_ if exists $words->{$_};
    }
    return @found;
}
