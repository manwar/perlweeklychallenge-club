#!/usr/bin/perl


=pod
#  N  3  2  3^
#  3  2^ 1  2
#  2  1  4  3
#  3^ 2  3  2

  a b c d
  --------
  N * * * |4
  * * * * |3
  * x * * |2
  * x x * |1

x : b1, b2, c1

b1 <-> b2 : 3
b1 <-> c1 : 3
b2 <-> c1 : 2
a4(N) <-> b1 : 2
a4 <-> b2 : 1
a4 <-> c1 : 3

N -> b1 -> b2 -> c1 : 2 + 3 + 2 = 7
N -> b1 -> c1 -> b2 : 2 + 3 + 2 = 7
N -> b2 -> b1 -> c1 : 1 + 3 + 3 = 7
N -> b2 -> c1 -> b1 : 1 + 2 + 3 = 6
N -> c1 -> b1 -> b2 : 3 + 3 + 3 = 9
N -> c1 -> b2 -> b1 : 3 + 2 + 3 = 8
=cut 

# The Weekly Challenge 118
# Task 2 Adventure of Knight
# Usage: ch-2.pl a2 b1 b2 b3 c4 e6

use strict;
use warnings;
use Algorithm::Combinatorics qw/permutations/;
#use Memoize;   # faster! learn from Mr Roger Bell_West's code

#memoize("expand"); # faster! learn from Mr Roger Bell_West's code

die "Give me positions with treasure!\n" unless $ARGV[0];
my @treasures = map { binumeric_position($_) } @ARGV;

my $min_path_length = 1000;
my @min_paths = ();



my $dist_tbl = 
   [[0,3,2,3,2,3,4,5],
    [3,2,1,2,3,4,3,4], # >[1][1] = 2 only if the target is not a corner
    [2,1,4,3,2,3,4,5],
    [3,2,3,2,3,4,3,4],
    [2,3,2,3,4,3,4,5],
    [3,4,3,4,3,4,5,4],
    [4,3,4,3,4,5,4,5],
    [5,4,5,4,5,4,5,6]] ;


my $iter = permutations( \@treasures );
while (my $p = $iter->next) {
    my $path_length = dist_fun([0,0], $p->[0]);
    my $i = 0;
    while ($i < $p->$#*) {
        $path_length += dist_fun($p->[$i], $p->[$i+1]);
        $i++;
    }
    compare_mini($path_length, $p);
}


my $total = scalar @min_paths;
print "The number of minimum path(s) is more than or equal to $total.\n";
print "Path length: $min_path_length.\n";
my $gd = int(rand($total));
print "Treasure spots shown only: ";
print join "=>", map {alphanumeric($_)} $min_paths[$gd]->@*;
print "\n\n";
print "A full path:\n";
print "   ", join "->", map {alphanumeric($_)}
                expand([0,0], $min_paths[$gd]->[0])->@*;
print "\n";
for my $s (0..$#treasures-1) {
    print "=> ";
    print join "->", map {alphanumeric($_)}
                expand($min_paths[$gd]->[$s], $min_paths[$gd]->[$s+1])->@*;
    print "\n";
}


sub dist_fun {
    my $A = $_[0];    
    my $B = $_[1];
    if (is_corner($A) or is_corner($B)) {
        return 4 if
          (abs($A->[0]-$B->[0]) == 1) and (abs($A->[1]-$B->[1]) == 1);
    }
    return 
      $dist_tbl->[abs($A->[0]-$B->[0])][abs($A->[1]-$B->[1])];
}


sub alphanumeric {
    my $a = $_[0];
    return chr(ord('a')+$a->[0]) . (8-$a->[1]);
}


sub compare_mini {
    if ($min_path_length >= $_[0]) {
        if ($min_path_length > $_[0]) {
            $min_path_length = $_[0];
            @min_paths = ();
        }
        push @min_paths, $_[1];
    }
}


sub binumeric_position {
    return [ord(substr($_[0],0,1)) - ord("a"), 8 - int substr($_[0],1,1)];
}


sub is_corner {
    my $a = $_[0];
    return (     ($a->[0] == 0 || $a->[0] == 7)
             and ($a->[1] == 0 || $a->[1] == 7) );
}


sub expand {

    my $t = dist_fun($_[0], $_[1]);
    return [$_[0], $_[1]] if $t == 1;

    my $board;
    my $visited;

    for my $k (0..63) {
        $board->[int $k / 8][$k % 8] = -1;
    }

    $board->[ $_[0]->[0] ][ $_[0]->[1] ] = 0;
    $visited->[ $_[0]->[0] ][ $_[0]->[1] ] = [ $_[0] ];

    my $s = 0;
    while ($s < $t) {
      for my $i (0..7) { 
        for my $j (0..7) {
          if ($board->[$i][$j] == $s) {
            for my $a ( [-2,-1],  [-1,-2],  [-2, 1],  [ 1,-2],
                        [-1, 2],  [ 2,-1],  [ 1, 2],  [ 2, 1])
            {
              my $ai = $i+$a->[0];
              my $aj = $j+$a->[1];
              if (  $ai >= 0 && $aj >= 0   #no negative index
                   && defined($board->[$ai][$aj]) #  no running outside board
                   && $board->[$ai][$aj] == -1) {
                $board->[$ai][$aj] = $s+1;
                $visited->[$ai][$aj] = [ @{$visited->[$i][$j]}, [$ai,$aj] ];
              }
            }
          }
        }
      }
      $s++;
    }

  return $visited->[ $_[1]->[0] ][ $_[1]->[1] ];
}



