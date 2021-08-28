#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: The Weekly Challenge 126
#  				Task 2 - Minesweeper Game
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 08/21/2021 12:09:52
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

# just printing the field is booooring, let's implement the whole game
# and yes, print the field at the end

my @field = [];
my $x = int(rand(0))+5;
my $y = int(rand(0))+5;

my $empty_fields = 0;
my @complete_field;
my @player_field;

sub init_field {
    for my $x_iter (0..$x) {
        for my $y_iter (0..$y) {
            $field[$x_iter][$y_iter] = "*";
            $field[$x_iter][$y_iter] = "x" if (rand() > 0.7);
            $player_field[$x_iter][$y_iter] = "*";
        }
    }
}

sub print_field {
    my $what = shift;

    print "     ";
    print "$_ " for (0..$y);
    
    print "\n    ";
    print "-"x(($y+1)*2);
    print "\n";
    for my $x_iter (0..$x) {
        print " ";
        print $x_iter." | ";
        for my $y_iter (0..$y) {
            print $what->[$x_iter][$y_iter]." ";
        }
        print "\n";
    }

}
sub calculate_field{
    for my $x_iter (0..$x) {
        for my $y_iter (0..$y) {
            if ($field[$x_iter][$y_iter] eq "x") {
                $complete_field[$x_iter][$y_iter] = "x";
            } else {
                my $counter = 0;

                for my $x_dir (-1, 0, 1) {
                    next if $x_dir + $x_iter > $x;
                    next if $x_dir + $x_iter < 0;

                    for my $y_dir (-1, 0, 1) {
                        next if $y_dir + $y_iter > $y;
                        next if $y_dir + $y_iter < 0;
                        
                        $counter++ if $field[$x_dir+$x_iter][$y_dir+$y_iter] eq "x";
                    }
                }
                $complete_field[$x_iter][$y_iter] = $counter;
                $empty_fields++;
            }
        }
    }
}

sub play_game {
    print "Find all fields without bombs \n";

    while ($empty_fields > 0) {
        print_field(\@player_field);
        print "Fields remain $empty_fields \n";
        print "Enter coordinates separated by space (for example 0 0):\n";

        my $input = <>;
        my @coords = split / /, $input;
        if ($field[$coords[0]][$coords[1]] eq "x") {
            print "BOOOOM! \n";

            print_field(\@complete_field);
            return;
        }

        if ($player_field[$coords[0]][$coords[1]] ne "*") {
            print "You tried that already \n";
            next;
        }

        $player_field[$coords[0]][$coords[1]] = $complete_field[$coords[0]][$coords[1]];
        $empty_fields--;
        

        if ($empty_fields == 0) {
            print "Congratulations, you won! \n";
            print_field(\@complete_field);
            return;
        }
    }
}

init_field;
calculate_field;
play_game;


