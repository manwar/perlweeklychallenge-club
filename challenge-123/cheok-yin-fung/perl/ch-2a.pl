#!/usr/bin/perl
# The Weekly Challenge 123
# Task 2 extension: Square/Cube/Hypercube Points
# Usage: ch-2a.pl (optional $k)  (optional)$D 
# $k: 2 or 3 or 4, stands for square or cube or hypercube, default is 3
# $D: 2 or above, cannot be smaller than $k, default is 3

use strict;
use warnings;
use v5.10.0;
use Test::More tests => 5; #7  #extend to 10 after writing cases for rotation
# extends after writing cases for 3D or above
use Algorithm::Combinatorics qw(permutations);  #use for hypercube


my $k = $ARGV[0] || 3;
my $D = $ARGV[1] || 3;

die "Usage: ch-2a.pl [2, 3 or 4] [(optional)dimension of space] " 
    if $k > 4 or $k <= 1;
die "How can I put a $k-polytope into $D-dim space? \n" if $k > $D;


sub is_square {
    my ($p0,$p1,$p2,$p3) = @_;
    my $v0 = vec_subtract($p0, $p1);
    my $v1 = vec_subtract($p0, $p2);
    my $v2 = vec_subtract($p0, $p3);
    return 0 unless (vec_prod($v1, $v2) == 0) xor
                    (vec_prod($v0, $v2) == 0) xor
                    (vec_prod($v0, $v1) == 0);
    return 0 unless vec_same($v0, vec_sum($v1, $v2) ) xor
                    vec_same($v1, vec_sum($v2, $v0) ) xor
                    vec_same($v2, vec_sum($v0, $v1) );
    my @n_vector = map { norm($_) } ($v0, $v1, $v2);
    @n_vector = sort {$a<=>$b} @n_vector;
    if ( $n_vector[0] == $n_vector[1] ) { 
        return 1;
    } 
    else {
        return 0;
    }
}

sub is_cube {
    my @p = @_;
    my %v;
    $v{$_} = vec_subtract($p[0], $p[$_]) for (1..7);
    my @ind = sort { norm($v{$a}) <=> norm($v{$b}) } keys %v;
    my ($N, $W, $U) = ($v{$ind[0]} , $v{$ind[1]} , $v{$ind[2]}) ;
    return 0 unless norm($N) == norm($W) && norm($N) == norm($U);
    return 0 unless vec_prod($N,$W) == 0 && vec_prod($W,$U) == 0 
                        && vec_prod($U,$N) == 0;
    my $NW = vec_sum($N, $W);
    my $WU = vec_sum($W, $U);
    my $UN = vec_sum($U, $N);
    my $bool = undef;
    if (vec_same($NW, $v{$ind[3]})) {
      if   (  vec_same($WU, $v{$ind[4]}) 
          &&  vec_same($UN, $v{$ind[5]}) ) { $bool = 1;
      } elsif ( vec_same($WU, $v{$ind[5]}) 
           &&   vec_same($UN, $v{$ind[4]}) ) { $bool = 1;
      } else {
        $bool = undef;
      }
    } 
    if (!$bool && vec_same($NW, $v{$ind[4]})) {
      if   (  vec_same($WU, $v{$ind[3]}) 
          &&  vec_same($UN, $v{$ind[5]}) ) { $bool = 1;
      } elsif ( vec_same($WU, $v{$ind[5]}) 
           &&   vec_same($UN, $v{$ind[3]}) ) { $bool = 1;
      } else {
        $bool = undef;
      }
    }
    if (!$bool && vec_same($NW, $v{$ind[5]})) {
      if   (  vec_same($WU, $v{$ind[4]}) 
          &&  vec_same($UN, $v{$ind[3]}) ) { $bool = 1;
      } elsif ( vec_same($WU, $v{$ind[3]}) 
           &&   vec_same($UN, $v{$ind[4]}) ) { $bool = 1;
      } else {
        return 0;
      }
    }
    return 0 if !$bool;

    my $NWU = vec_sum( $N, vec_sum($W, $U) );
    if ( vec_same( $v{$ind[6]} , $NWU ) ) {
        return 1;
    }
    else {
        return 0;
    }
=pod 
   if ( vec_same( $v{$ind[6]} , $NWU ) ) {
        return 0 unless
            2*norm($N) == norm($NW) &&
            norm($NW) == norm($WU) &&
            norm($WU) == norm($UN) &&
            3*norm($N) == norm($NWU);
        return 1;
    } else {
        return 0;
    }
=cut
}

sub is_hypercube {
    my @p = @_;
    my %v;
    $v{$_} = vec_subtract($p[0], $p[$_]) for (1..15);
    my @ind = sort { norm($v{$a}) <=> norm($v{$b}) } keys %v;
    my ($N, $W, $U, $A) = ( $v{$ind[0]}, $v{$ind[1]} , 
                            $v{$ind[2]}, $v{$ind[3]} );
    return 0 unless 
        norm($N) == norm($W) && norm($W) == norm($U)
                             && norm($U) == norm($A);
    return 0 unless 
        vec_prod($N, $W) == 0 &&
        vec_prod($N, $U) == 0 &&
        vec_prod($N, $A) == 0 &&
        vec_prod($A, $W ) == 0 &&
        vec_prod($A, $U ) == 0 &&
        vec_prod($W, $U ) == 0 ;
    my $AU = vec_sum($A, $U);
    my $AW = vec_sum($A, $W);
    my $AN = vec_sum($A, $N);
    my $NW = vec_sum($N, $W);
    my $WU = vec_sum($W, $U);
    my $UN = vec_sum($U, $N);
    my $bool_face = undef;
    my $iter_face = permutations([$AU, $UN, $NW, $WU, $AW, $AN]);
    while (!$bool_face && (my $p = $iter_face->next)) {
        $bool_face = 
            vec_same($v{$ind[4]}, $AU) &&
            vec_same($v{$ind[5]}, $UN) &&
            vec_same($v{$ind[6]}, $NW) &&
            vec_same($v{$ind[7]}, $WU) &&
            vec_same($v{$ind[8]}, $AW) &&
            vec_same($v{$ind[9]}, $AN) ;
    }
    return 0 if !$bool_face;

    my $UNW = vec_sum($UN, $W);
    my $ANW = vec_sum($NW, $A);
    my $AWU = vec_sum($WU, $A);
    my $AUN = vec_sum($UN, $A);
    my $bool_cube = undef;
    my $iter_cube = permutations([$UNW, $ANW, $AWU, $AUN]);
    while (!$bool_cube && (my $p = $iter_cube->next)) {
        $bool_cube = 
            vec_same($v{$ind[10]}, $UNW) &&
            vec_same($v{$ind[11]}, $ANW) &&
            vec_same($v{$ind[12]}, $AWU) &&
            vec_same($v{$ind[13]}, $AUN);
    }
    return 0 if !$bool_cube;
    my $AUNW = vec_sum($AU,$NW);
    if ( vec_same($v{$ind[14]}, $AUNW) ) {
        return 1;
    }
    else {
        return 0;
    }
=pod
    if ( vec_same($v{$ind[14]}, $AUNW) ) {
        return 0 unless 
            2*norm($N) == norm($NW) &&
            norm($NW) == norm($AU) &&
            norm($NW) == norm($UN) &&
            norm($NW) == norm($WU) &&
            norm($NW) == norm($AW) &&
            norm($NW) == norm($AN) &&
            3*norm($N) == norm($UNW) &&
            3*norm($N) == norm($ANW) &&
            3*norm($N) == norm($AWU) &&
            3*norm($N) == norm($AUN) &&
            4*norm($N) == norm($AUNW);
        return 1;
    } else {
        return 0;
    }
=cut
}

sub vec_prod {
    my $first = $_[0];
    my $second = $_[1];
    die "Not the same dimension in vec_prod \n" if $first->$#* != $second->$#*;
    my $sum = 0;
    $sum+= ($first->[$_]*$second->[$_]) for (0..$first->$#*);
    return $sum;
}

sub norm {
    my $p = $_[0];
    my $sum = 0;
    $sum+= ($p->[$_])**2 for (0..$p->$#*);
    return $sum;
}

sub vec_sum {
    my $first = $_[0];
    my $second = $_[1];
    my $ans = [];
    die "Not the same dimension in vec_sum \n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        push $ans->@*, $first->[$s] + $second->[$s];
    }
    return $ans;
}

sub vec_same {
    my $first = $_[0];
    my $second = $_[1];
    die "Not the same dimension in vec_same \n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        return undef if $first->[$s] != $second->[$s];
    }
    return 1;
}

sub vec_subtract {
    my $first = $_[0];
    my $second = $_[1];
    my $ans = [];
    die "Not the same dimension in vec_subtract\n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        push $ans->@*, $second->[$s] - $first->[$s];
    }
    return $ans;
}

# 2 tests
ok is_square( [1, 2] , [4,3], [3,1], [2,4] ) == 1, "Knight's square";
ok is_square( [1, 1] , [-1, 1], [ 1,-1], [-1,-1] ) == 1, "centre at origin";

# 3 tests
ok is_cube( [1, 1, 1], [1, 1, 0], [1, 0, 1], [1, 0, 0], 
            [0, 1, 1], [0, 1, 0], [0, 0, 1], [0, 0, 0] ) == 1, 
            "standard 2**3";
ok is_cube([ -2, -2, -2], [ -2, -2,  2], [ -2,  2, -2], [ -2,  2,  2], 
           [  2, -2, -2], [  2, -2,  2], [  2,  2, -2], [  2,  2,  2]) == 1, 
            "center at origin";
# ok is_cube( [1, 1, 1] , [-1,1], [1,-1], [-1,-1] ) == 1, 
#           "a rotated cube centred at somewhere";
ok is_cube([  2,  2,  2], [  2,  3,  2], [  2,  2,  3], [  2,  4,  2], 
           [  3,  3,  2], [  2,  2,  1], [  2,  3,  2], [  2,  7,  3]) == 0, 
            "not a cube";


# test for hypercube is needed
