#!/usr/bin/env perl6
#
# Wrap paragraph provided on stdin using greedy algorithm
#

    my @words       = do { slurp.words };
    my $word_width  = 0;

    my $line_width  = 20;
    my $space_left  = $line_width;
    my $space_width = 1;


for @words -> $w {

    $word_width = $w.chars;
    if ( ($space_left < $line_width)  &&  ($space_width + $word_width <= $space_left) )
    {
        printf " $w";
        $space_left -= ( $space_width + $word_width );
    }
    else
    {
        printf "{ $space_left == $line_width ?? "" !! "\n" }$w";
        $space_left = $line_width - $word_width;
    };
}

printf "\n";
