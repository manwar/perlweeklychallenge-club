#!/usr/bin/perl
# The Weekly Challenge 118
# Task 2 Adventure of Knight
# Pre-processing file
use strict;
use warnings;


=pod
    z  a  b  c  d  e  f  g  h  
X|  ~  ~  ~  ~  ~  ~  ~  ~  ~  
0|  ~  0  *  *  *  *  *  *  *  
1|  ~  *  *  1  *  *  *  *  *
2|  ~  *  1  *  *  *  *  *  *
3|  ~  *  *  *  *  *  *  *  *
4|  ~  *  *  *  *  *  *  *  *
5|  ~  *  *  *  *  *  *  *  *
6|  ~  *  *  *  *  *  *  *  *
7|  ~  *  *  *  *  *  *  *  *

    z  a  b  c  d  e  f  g  h  
X|  ~  ~  ~  ~  ~  ~  ~  ~  ~  
0|  ~  0  *  *  *  2  *  *  *  
1|  ~  *  2^ 1  *  *  *  *  *
2|  ~  *  1  *  *  2  *  *  *
3|  ~  *  *  *  2  *  *  *  *
4|  ~  2  *  2  *  *  *  *  *
5|  ~  *  *  *  *  *  *  *  *
6|  ~  *  *  *  *  *  *  *  *
7|  ~  *  *  *  *  *  *  *  *

=cut


my $board;


for my $k (1..63) {
    $board->[int $k / 8][$k % 8] = -1;
}

$board->[0][0] = 0;
$board->[1][1] = 2;

my $total = 62;
my $t = 0;
while ($total > 0) {
  for my $i (0..7) { 
    for my $j (0..7) {
      if ($board->[$i][$j] == $t) {
        for my $a ( [-2,-1],  [-1,-2],  [-2, 1],  [ 1,-2],  
                    [-1, 2],  [ 2,-1],  [ 1, 2],  [ 2, 1])
        {
          my $ai = $i+$a->[0];
          my $aj = $j+$a->[1];
          if (  $ai >= 0 && $aj >= 0   #no negative index
               && defined($board->[$ai][$aj]) #  no running outside board
               && $board->[$ai][$aj] == -1) {
            $board->[$ai][$aj] = 1 + $t;  
            $total--;
          }
        }
      }
    }
  }
  $t++;
}

for my $i (0..7) {
  for my $j (0..7) {
    print $board->[$i][$j], " " if $board->[$i][$j] >= 0;
    print "*", " " if $board->[$i][$j] == -1;
  }
  print "\n";
}

