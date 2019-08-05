#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Write a script that can wrap the given paragraph
# at a specified column using the greedy algorithm.
#   https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap#Minimum_number_of_lines

##      SpaceLeft := LineWidth
##      for each Word in Text
##          if (Width(Word) + SpaceWidth) > SpaceLeft
##              insert line break before Word in Text
##              SpaceLeft := LineWidth - Width(Word)
##          else
##              SpaceLeft := SpaceLeft - (Width(Word) + SpaceWidth)

my $text = q{
    Let me announce the winner of Perl Weekly Challenge - 018 and the 
    name is E. Choroba. Many congratulations Choroba, you should soon 
    hear from Perl Careers about your reward. Please do let us know how 
    you feel about it. For rest of the participants, I would say Good 
    Luck for next time. Keep sending in your solutions and share your 
    knowledge with each other.
};

say word_wrap( 30, $text );
say '';
say word_wrap( 60, $text );
say '';
say word_wrap( 80, $text );
say '';

sub word_wrap ( $col, $text ) {
    my @text = grep { /\S/ } split /\s+/, $text;
    my $output;
    my $line       = '';
    my $space_left = $col;
    for my $word (@text) {
        my $width = length $word;
        if ( ( $width + 1 ) > $space_left ) {
            $output .= "\n" . $word . ' ';
            $space_left = $col - ( $width + 1 );
        }
        else {
            $output .= $word . ' ';
            $space_left -= ( $width + 1 );
        }
    }
    return $output;
}

