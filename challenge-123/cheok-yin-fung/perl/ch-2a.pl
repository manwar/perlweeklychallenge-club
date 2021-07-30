#!/usr/bin/perl
# The Weekly Challenge 123
# Task 2 extension: Square/Cube/Hypercube Points
# Usage: $ ch-2a.pl (optional) $k (optional)$D 
# $k: 2 or 3 or 4, stands for square or cube or hypercube, default is 3
# $D: 2 or above, cannot be smaller than $k, default is same as $k

# Note: check out $ diff ch-2a.pl ch-2ax.pl
# ALSO: ch-2x.pl is the best implementation.

use strict;
use warnings;
use v5.10.0;
use Test::More tests => 14; 

use Algorithm::Combinatorics qw(permutations);  #use for hypercube


my $k = $ARGV[0] || 3;
my $D = $ARGV[1] || $k;

die "Usage: ch-2a.pl [2, 3 or 4] (optional)[dimension of space] " 
    if $k > 4 or $k <= 1;
die "How can I put a $k-polytope into $D-dim space? \n" if $k > $D;


sub is_square {
    my ($p0,$p1,$p2,$p3) = @_;
    my $v0 = vec_subtract($p0, $p1);
    my $v1 = vec_subtract($p0, $p2);
    my $v2 = vec_subtract($p0, $p3);
    return 0 unless (vec_prod_f($v1, $v2) == 0) xor
                    (vec_prod_f($v0, $v2) == 0) xor
                    (vec_prod_f($v0, $v1) == 0);
#========== BEGIN: diff of ch-2a.pl and ch-2ax.pl =========
    return 0 unless vec_same($v0, vec_sum($v1, $v2) ) xor
                    vec_same($v1, vec_sum($v2, $v0) ) xor
                    vec_same($v2, vec_sum($v0, $v1) );
#=========== END: diff of ch-2a.pl and ch-2ax.pl ==========
# COMMENT:
#  this test is mathematically NOT necessary, 
#  and if you check it against ch-2ax.pl,
#  you will find this section is the source of failed tests!
    my @n_vector = map { norm_f($_) } ($v0, $v1, $v2);
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
    my @ind = sort { norm_f($v{$a}) <=> norm_f($v{$b}) } keys %v;
    my ($N, $W, $U) = ($v{$ind[0]} , $v{$ind[1]} , $v{$ind[2]}) ;
    return 0 unless norm_f($N) == norm_f($W) && norm_f($N) == norm_f($U);
    return 0 unless vec_prod_f($N,$W) == 0 && vec_prod_f($W,$U) == 0 
                        && vec_prod_f($U,$N) == 0;
    my $NW = vec_sum($N, $W);
    my $WU = vec_sum($W, $U);
    my $UN = vec_sum($U, $N);
    my $bool = undef;
    if (vec_same($NW, $v{$ind[3]})) {
      if   (  vec_same($WU, $v{$ind[4]}) 
          &&  vec_same($UN, $v{$ind[5]}) ) { $bool = 1;
      } elsif ( vec_same($WU, $v{$ind[5]}) 
           &&   vec_same($UN, $v{$ind[4]}) ) { $bool = 1;
      }
    } 
    if (!$bool && vec_same($NW, $v{$ind[4]})) {
      if   (  vec_same($WU, $v{$ind[3]}) 
          &&  vec_same($UN, $v{$ind[5]}) ) { $bool = 1;
      } elsif ( vec_same($WU, $v{$ind[5]}) 
           &&   vec_same($UN, $v{$ind[3]}) ) { $bool = 1;
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

    my $NWU = vec_sum( $N, $WU);
    if ( vec_same( $v{$ind[6]} , $NWU ) ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub is_hypercube {
    my @p = @_;
    my %v;
    $v{$_} = vec_subtract($p[0], $p[$_]) for (1..15);
    my @ind = sort { norm_f($v{$a}) <=> norm_f($v{$b}) } keys %v;
    my ($N, $W, $U, $A) = ( $v{$ind[0]}, $v{$ind[1]} , 
                            $v{$ind[2]}, $v{$ind[3]} );
    return 0 unless 
        norm_f($N) == norm_f($W) && norm_f($W) == norm_f($U)
                             && norm_f($U) == norm_f($A);
    return 0 unless 
        vec_prod_f($N, $W) == 0 &&
        vec_prod_f($N, $U) == 0 &&
        vec_prod_f($N, $A) == 0 &&
        vec_prod_f($A, $W) == 0 &&
        vec_prod_f($A, $U) == 0 &&
        vec_prod_f($W, $U) == 0 ;

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
            vec_same($v{$ind[4]}, $p->[0]) &&
            vec_same($v{$ind[5]}, $p->[1]) &&
            vec_same($v{$ind[6]}, $p->[2]) &&
            vec_same($v{$ind[7]}, $p->[3]) &&
            vec_same($v{$ind[8]}, $p->[4]) &&
            vec_same($v{$ind[9]}, $p->[5]) ;
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
            vec_same($v{$ind[10]}, $p->[0]) &&
            vec_same($v{$ind[11]}, $p->[1]) &&
            vec_same($v{$ind[12]}, $p->[2]) &&
            vec_same($v{$ind[13]}, $p->[3]);
    }
    return 0 if !$bool_cube;

    my $AUNW = vec_sum($AU,$NW);
    if ( vec_same($v{$ind[14]}, $AUNW) ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub vec_prod {
    my $first = $_[0];
    my $second = $_[1];
    warn "Not the same dimension in vec_prod \n" if $first->$#* != $second->$#*;
    my $sum = 0;
    $sum+= ($first->[$_]*$second->[$_]) for (0..$first->$#*);
    return $sum;
}

sub vec_prod_f {
    return sprintf("%f", vec_prod($_[0], $_[1]));
}

sub norm {
    my $p = $_[0];
    my $sum = 0;
    $sum+= ($p->[$_])**2 for (0..$p->$#*);
    return $sum;
}

sub norm_f {
    return sprintf("%f", norm($_[0]));
}

sub vec_sum {
    my $first = $_[0];
    my $second = $_[1];
    my $ans = [];
    warn "Not the same dimension in vec_sum \n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        push $ans->@*, $first->[$s] + $second->[$s];
    }
    return $ans;
}

sub vec_same {
    my $first = $_[0];
    my $second = $_[1];
    warn "Not the same dimension in vec_same \n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        return undef if $first->[$s] != $second->[$s];
    }
    return 1;
}

sub vec_subtract {
    my $first = $_[0];
    my $second = $_[1];
    my $ans = [];
    warn "Not the same dimension in vec_subtract\n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        push $ans->@*, $second->[$s] - $first->[$s];
    }
    return $ans;
}



# 9 tests
ok is_square( [1,0], [0,1], [-1,0],[0,-1]) == 1, "on x-axis and y-axis";

ok is_square( [5/sqrt(26), 1/sqrt(26)], 
              [-1/sqrt(26), 5/sqrt(26)],
              [-5/sqrt(26), -1/sqrt(26)], 
              [1/sqrt(26), -5/sqrt(26)]) == 1,
             "inclined by arctan(1/5), centre at origin"; 

ok is_square( 
              [cos(atan2(1,5)), sin(atan2(1,5))], 
              [-sin(atan2(1,5)), cos(atan2(1,5))],
              [-cos(atan2(1,5)), -sin(atan2(1,5))],
              [sin(atan2(1,5)), -cos(atan2(1,5))]
            )  
              == 1, "arctan(1/5) by atan2(), caught by the equalities";  

ok is_square( 
              [2.7*cos(atan2(1,5)), 2.7*sin(atan2(1,5))], 
              [-2.7*sin(atan2(1,5)), 2.7*cos(atan2(1,5))],
              [-2.7*cos(atan2(1,5)), -2.7*sin(atan2(1,5))],
              [2.7*sin(atan2(1,5)), -2.7*cos(atan2(1,5))]
            )  
              == 1, 
             "arctan(1/5) by atan2() of larger size (multipled by 2.7)," 
            ."caught by the equalities";  

ok is_square( 
              [2.8*cos(atan2(1,5)), 2.8*sin(atan2(1,5))], 
              [-2.8*sin(atan2(1,5)), 2.8*cos(atan2(1,5))],
              [-2.8*cos(atan2(1,5)), -2.8*sin(atan2(1,5))],
              [2.8*sin(atan2(1,5)), -2.8*cos(atan2(1,5))]
            )  
              == 1, 
             "arctan(1/5) by atan2() of larger size (multipled by 2.8),"
            ."caught by the equalities";  

ok is_square( 
              [4.0*cos(atan2(1,5)), 4.0*sin(atan2(1,5))], 
              [-4.0*sin(atan2(1,5)), 4.0*cos(atan2(1,5))],
              [-4.0*cos(atan2(1,5)), -4.0*sin(atan2(1,5))],
              [4.0*sin(atan2(1,5)), -4.0*cos(atan2(1,5))]
            )  
              == 1, 
             "arctan(1/5) by atan2() of larger size (multipled by 4.0),"
            ." caught by the equalities";  

ok is_square( 
              [0.0009*cos(atan2(1,5)), 0.0009*sin(atan2(1,5))], 
              [-0.0009*sin(atan2(1,5)), 0.0009*cos(atan2(1,5))],
              [-0.0009*cos(atan2(1,5)), -0.0009*sin(atan2(1,5))],
              [0.0009*sin(atan2(1,5)), -0.0009*cos(atan2(1,5))]
            )  
              == 1, 
             "arctan(1/5) by atan2() of a much smaller size"
            ."(multiple by 0.0009), caught by the equalities"
            ."(_\"not ok\" is normal_)";  

ok is_square( [1, 2] , [4,3], [3,1], [2,4] ) == 1, "Knight's square";
ok is_square( [1, 1] , [-1, 1], [1,-1], [-1,-1] ) == 1, "centre at origin";

# 4 tests
ok is_cube( [1, 1, 1], [1, 1, 0], [1, 0, 1], [1, 0, 0], 
            [0, 1, 1], [0, 1, 0], [0, 0, 1], [0, 0, 0] ) == 1, 
            "standard 2**3";
ok is_cube([ -2, -2, -2], [ -2, -2,  2], [ -2,  2, -2], [ -2,  2,  2], 
           [  2, -2, -2], [  2, -2,  2], [  2,  2, -2], [  2,  2,  2]) == 1, 
            "centre at origin";
ok is_cube( 
            [-2, -2*sqrt(3), 3-2*sqrt(3)]   ,  
            [-2, 4-2*sqrt(3), 3+2*sqrt(3)],    
            [-2, 2*sqrt(3), -2*sqrt(3)-1 ],  
            [-2, 4+2*sqrt(3), -1+2*sqrt(3) ], 
            [ 6, -2*sqrt(3), 3-2*sqrt(3)],
            [ 6, 4-2*sqrt(3), 3+2*sqrt(3)],
            [ 6, 2*sqrt(3), -2*sqrt(3)-1],
            [ 6, 4+2*sqrt(3), -1+2*sqrt(3)]
           ) 
              == 1, "a rotated cube centred at (2,2,1)";
ok is_cube([  2,  2,  2], [  2,  3,  2], [  2,  2,  3], [  2,  4,  2], 
           [  3,  3,  2], [  2,  2,  1], [  2,  3,  2], [  2,  7,  3]) == 0, 
            "this is not a cube";

# 1 test
ok is_hypercube(
                [0,0,0,0],[0,0,0,1],[0,0,1,0],
                [0,0,1,1],[0,1,0,0],[0,1,0,1],
                [0,1,1,0],[0,1,1,1],[1,0,0,0],
                [1,0,0,1],[1,0,1,0],[1,0,1,1],
                [1,1,0,0],[1,1,0,1],[1,1,1,0],
                [1,1,1,1]
               ) == 1, "hypercube";
done_testing();
