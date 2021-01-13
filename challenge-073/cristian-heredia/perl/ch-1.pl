#TASK #1 › Min Sliding Window
#Submitted by: Mohammad S Anwar
#You are given an array of integers @A and sliding window size $S.
#
#Write a script to create an array of min from each sliding window.
#
#Example
#Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
#Output: (0, 0, 0, 2, 3, 3, 4, 4)
#
#[(1 5 0) 2 9 3 7 6 4 8] = Min (0)
#[1 (5 0 2) 9 3 7 6 4 8] = Min (0)
#[1 5 (0 2 9) 3 7 6 4 8] = Min (0)
#[1 5 0 (2 9 3) 7 6 4 8] = Min (2)
#[1 5 0 2 (9 3 7) 6 4 8] = Min (3)
#[1 5 0 2 9 (3 7 6) 4 8] = Min (3)
#[1 5 0 2 9 3 (7 6 4) 8] = Min (4)
#[1 5 0 2 9 3 7 (6 4 8)] = Min (4)

use strict;
use warnings;
use Data::Dumper;
use List::Util qw(min);

#Input
my @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8);
my $S = 3; #SlidingWindow

#variables
my @window;
my @outout;
my $counter = 0;
my $next = 0;
my $lenght = @A;
my $max = $lenght - $S + 1;

slidingWindow();

sub slidingWindow {
   
    if ($next != $max) {
       
        if ($counter == $S ) {
            $counter = 0;
            $next++;
            $S++;
            @window = ();
            slidingWindow();
        }
        else {
            foreach (my $i = $next; $i<$S; $i++) {
                push @window, $A[$i];
            }
            $counter = $S;
            push @outout, min(@window);
            slidingWindow();
        }
    }
    else {
        print Dumper \@outout;
    }
}
