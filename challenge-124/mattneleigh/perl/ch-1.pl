#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

foreach(generate_venus_symbol(13, '^')){
    printf("%s\n", $_);
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Produce a series of text lines with a Venus symbol drawn therein using a
# specified charcter
# Takes two arguments:
# * The width (W) of the intended plot, in characters
# * The character to plot with
# Returns on success:
# * An array of W lines of W characters each, all of which will be spaces,
#   except where the symbol was drawn
# Returns on error:
# * undef if the specified width wasn't at least 2
################################################################################
sub generate_venus_symbol{
    my $width = shift();
    my $character = shift();

    my @lines;
    my @blanks;
    my $i;
    my $middle;

    return(undef) unless($width >= 2);

    $middle = round($width / 2);

    # Make sure the character is... one
    # character
    $character = substr($character, 0, 1);

    # Make the circular part of the symbol
    push(@lines, generate_text_circle($width, $character));

    # Make the base of the symbol- start
    # by finding out where the circle ends
    while($#lines > -1){
        if(
            substr($lines[$#lines], $middle, 1)
            eq
            $character
        ){
            # Reached the circle
            last;
        } else{
            # Blank line- strip it and store
            # it elsewhere for later
            push(@blanks, pop(@lines));
        }
    }

    # Then add some lines with particular
    # replacements made
    $i = round($width * 0.6);
    while($i--){
        push(@lines, $blanks[0]);
        if($i == round($width * 0.3)){
            # Horizontal crossbar
            my $length = round($width * 0.5);

            substr(
                $lines[$#lines],
                round($middle - $length / 2),
                $length
            ) = $character x $length;
        } else{
            # Vertical stem
            substr($lines[$#lines], $middle, 1) = $character;
        }
    }

    # Stick the blank footer lines back on;
    # assignment in this expression is
    # deliberate
    while($_ = pop(@blanks)){
        push(@lines, $_);
    }

    return(@lines);

}



################################################################################
# Produce a series of text lines with a circle drawn therein using a specified
# charcter.
# Takes two arguments:
# * The width (W) of the intended plot, in characters
# * The character to plot with
# Returns on success:
# * An array of W lines of W characters each, all of which will be spaces,
#   except where the circle was drawn
# Returns on error:
# * undef if the specified width wasn't at least 2
# NOTE: While the text output of this function is a WxW array, in most
# typefaces a printout of this circle is likely to be anamorphically distorted.
# The circle plotting method used is a minor modification of the process
# descried here: https://weber.itn.liu.se/~stegu/circle/circlealgorithm.pdf
################################################################################
sub generate_text_circle{
    my $width = shift();
    my $character = shift();

    my @lines;
    my $radius;
    my $x;
    my $y;
    my $d;
    my $dA;
    my $dB;

    return(undef) unless($width >= 2);

    $radius = round($width / 2) - 2;

    # Establish a blank canvas
    push(@lines, " " x $width);
    $y = $width;
    while($y--){
        push(@lines, $lines[0]);
    }

    # Re-use this to center the circle...
    $width = round($width / 2);

    # Plot a circle on it
    $x = 0;
    $y = $radius;
    $d = 5 - 4 * $radius;
    $dA = 12;
    $dB = 20 - 8 * $radius;
    while($x <= $y){
        # Draw part of the circle
        substr(
            $lines[round($width - $y)], round($width - $x), 1
        ) = $character;
        substr(
            $lines[round($width - $y)], round($width + $x), 1
        ) = $character;
        substr(
            $lines[round($width + $y)], round($width - $x), 1
        ) = $character;
        substr(
            $lines[round($width + $y)], round($width + $x), 1
        ) = $character;

        substr(
            $lines[round($width - $x)], round($width - $y), 1
        ) = $character;
        substr(
            $lines[round($width - $x)], round($width + $y), 1
        ) = $character;
        substr(
            $lines[round($width + $x)], round($width - $y), 1
        ) = $character;
        substr(
            $lines[round($width + $x)], round($width + $y), 1
        ) = $character;

        if($d < 0){
            $d += $dA;
            $dB += 8;
        } else{
            $y--;
            $d += $dB;
            $dB += 16;
        }
        $x++;
        $dA += 8;
    }

    return(@lines);

}



################################################################################
# Round a floating point number to the nearest integer; will round away from 0
# if the fractional portion of the number is greater or equal to abs(0.5)
# Takes one argument:
# * The number to round
# Returns:
# * The rounded number
################################################################################
sub round{
    my $n = shift();

    return(
        abs($n - int($n)) < 0.5
        ?
        int($n)
        :
        int($n) + abs($n)/$n
    );

}



