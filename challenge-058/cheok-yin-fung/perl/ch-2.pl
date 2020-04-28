#!/usr/bin/perl
use strict;

# reference: 
# http://mathonline.wikidot.com/generating-permutations-with-inversion-sequences

# begin: from the question statement
# Heights
my @H = (27, 21, 37,  4, 19, 52, 23, 64,  1,  7, 51, 17, 24, 50,  3,  2,
  34, 40, 47, 20,  8, 56, 14, 16, 42, 38, 62, 53, 31, 41, 55, 59,
      48, 12, 32, 61,  9, 60, 46, 26, 58, 25, 15, 36, 11, 44, 63, 28,
      5, 54, 10, 49, 57, 30, 29, 22, 35, 39, 45, 43, 18,  6, 13, 33);

# Number taller people in front
   my @T = ( 6, 41,  1, 49, 38, 12,  1,  0, 58, 47,  4, 17, 26,  1, 61, 12,
         29,  3,  4, 11, 45,  1, 32,  5,  9, 19,  1,  4, 28, 12,  2,  2,
      13, 18, 19,  3,  4,  1, 10, 16,  4,  3, 29,  5, 49,  1,  1, 24,
       2,  1, 38,  7,  7, 14, 35, 25,  0,  5,  4, 19, 10, 13,  4, 12);

#my @H = (2, 6, 4, 5, 1, 3) ;
##my @T = (1, 0, 2, 0, 1, 2) ;

# end: from the question statement

my $N = $#H+1;

my %height_appeartime;
for (1..$N) { $height_appeartime{$_} = $H[$_-1]; }
my %id_sorted = reverse %height_appeartime;

# @id  --> id according to height
my @id =  map { $id_sorted{$_} } ( sort {$a<=>$b} keys %height_appeartime);

my @inversion_seq = map {$T[$_-1] } @id;



my @placement = ((-1) x $N);

for my $i (0..$N-1) {
    my @possible_place = ();
    for (0..$N-1) {
        push @possible_place, $_ if $placement[$_] == -1;
    }
    if ( defined($possible_place[$inversion_seq[$i]]) ) {
        $pos = $possible_place[ $inversion_seq[$i] ]; 
    } else {die "ERROR";}

    $placement[ $pos ] = $i;
}

@placement = map { $_+1 } @placement;

print join ", " , @placement;
