#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-101 TASK #1
my @array = @ARGV;
@array = (1,2,3,4) if (scalar @ARGV == 0); 
my $size = @array;

# Find factors with minimal difference with these steps:
#   1. get the square root of $size
#   2. round it down to a integer
#   3. deduct 1 until it factors $size evenly
# Examples
#   the square root of  9 is 3, stop
#   the square root of 12 is 3.4641, 12/3 = 4, stop
#   the square root of 14 is 3.7416, 14/3 = 4.666, 14/2 = 7, stop
my ($m, $n) = (int(sqrt($size)), 1);
$n = $size/$m;
until ($n - int($n) == 0) {
    $m--;
    $n = $size/$m;
}

# Init matrix of dimensions $m, $n
$m--; $n--; # matrix is zero indexed
my $matrix = [];
for my $y (0 .. $m) {
    for my $x (0 .. $n) {
        $matrix->[$y][$x] = 0; 
    }
}

# Init bounding box walls and set matrix index to origin at (a,b)
my ($a, $b, $c, $d) = (0, 0, $n, $m); 
my ($x, $y) = ($a, $b);

# Populate matrix by spiralling counterclockwise
# Start by heading east along the bottom of the matrix
my ($east, $north, $west, $south) = (1, 2, 3, 4);
my $dir = $east; 
foreach my $e (@array) {
    $matrix->[$y][$x] = $e;

    if ($dir == $east) {
        $x++;
        if ($x == $c) {
            $dir = $north;
            $a++; # heading north raise the floor
        }
    }
    elsif ($dir == $north) { 
        $y++; 
        if ($y == $d) {
            $dir = $west; 
            $c--; # heading west move right wall to the left
        }
    }
    elsif ($dir == $west) { 
        $x--;
        if ($x < $a) {
            $dir = $south;
            $d--; # heading south, lower the ceiling
        }
    }
    elsif ($dir == $south) { 
        $y--;
        if ($y == $b) {
            $dir = $east;
            $b++; # heading east move left wall to the right

            # set (x,y) to origin of contracted bounding box
            ($x, $y) = ($a, $b); 
        }
    }
}

# Print the matrix
($a, $b, $c, $d) = (0, 0, $n, $m);

my $out; # output string
my @y = reverse ($b .. $d);
for my $y (@y) {
    $out .= "\t[ ";
    foreach my $x ($a .. $c) {
        $out .= $matrix->[$y][$x] . " ";
    }
    $out .= "]\n";
}
say $out;

__END__


./ch-1.pl  A B C D
        [ D C ]
        [ A B ]

./ch-1.pl  A B C D E F
        [ F E D ]
        [ A B C ]

./ch-1.pl  A B C D E F G H 
        [ H G F E ]
        [ A B C D ]

./ch-1.pl  A B C D E F G H I
        [ G F E ]
        [ H I D ]
        [ A B C ]

./ch-1.pl  A B C D E F G H I J K L M N O
        [ K J I H G ]
        [ L M N O F ]
        [ A B C D E ]

/ch-1.pl  A B C D E F G H I J K L M N O P Q R S T U V W X Y
        [ M L K J I ]
        [ N W V U H ]
        [ O X Y T G ]
        [ P Q R S F ]
        [ A B C D E ]

