#!/usr/bin/perl
use strict;
use warnings;
# The Weekly Challenge #101 Task 1 Pack a Spiral
# Usage: ch-1.pl [items]
# modify from my code for challenge #088 "Spiral Matrix"

use List::Util qw/max/;


sub my_printf {
    print " " x ( $_[1] - (length $_[0]) );
    print $_[0];
}

sub closest_factorization {
    my $num = $_[0];
    my $factor1 = 1;
    my $factor2 = 1;
    for my $int ( 1 .. $num ) {
        if ($num % $int == 0) {
            $factor1 = $factor2;
            $factor2 = $int;
        }
        last if $factor1 * $factor2 >= $num;
    }

    if ($factor1*$factor1 != $num) {
        return ($factor1, $factor2); 
    } else 
    {
        return ($factor1, $factor1);
    }
}


sub print_matrix_ad {
    my @mat = @{$_[0]};  
    my $M = scalar @mat;
    my $N = scalar @{$mat[0]};

    my @columnlength;
    for my $i (0..$N-1) {$columnlength[$i] = 1;}
    for my $i (0..$N-1) {
        for my $j (0..$M-1) {
            $columnlength[$i] = max($columnlength[$i], 1+ (length $mat[$j]->[$i]));
        }
    }

    for my $j (0..$M-1) {
        for my $i (0..$N-1) {        
            my_printf($mat[$j]->[$i], $columnlength[$i]);
        }
        print "\n";
    }

}


sub matrixize_anticlockwise {  
    my @list = @{$_[0]};
    my $M = $_[1];
    my $N = $_[2];
    my @mat;
    my @helper_mat;

#BEGIN: special case handling: the numbers of entries is prime
    if ($M == 1) {return \@list;}
#END: special case handling


    my @row_dir = (  0, -1,  0, +1 );
    my @col_dir = ( +1,  0, -1,  0 );

    my ($r, $c) = ( $M-1 , 0);
    ${$mat[$r]}[$c] = $list[0];
    ${$helper_mat[$r]}[$c] = 1;

    my @numbering = (
        [1..$N-1], 
        [$N..$N+$M-2], 
        [$N+$M-1..$N+$M+$N-3], 
        [$N+$M+$N-2..($M-1)*2+($N-1)*2-1]
    );

    my $count = 1;
    for my $q (0..3) {
        for (@{$numbering[$q]}) {
            $r += $row_dir[$q];
            $c += $col_dir[$q];

            ${$mat[$r]}[$c] = $list[$count];
            ${$helper_mat[$r]}[$c] = 1;

            $count++;
        }
    }

    my $time_now = 3;
    my $success_click = undef;
    while ($count < $M*$N) {
        if ($success_click) {
            $r += $row_dir[$time_now];
            $c += $col_dir[$time_now];
            if (!defined ${$helper_mat[$r]}[$c]  )
            {
                ${$mat[$r]}[$c] = $list[$count];
                ${$helper_mat[$r]}[$c] = 1;
                $success_click = 1;
                $count++;
            } else 
            {
                $success_click = undef; 
                $r -= $row_dir[$time_now];
                $c -= $col_dir[$time_now];
            }
        } else 
        {
            $time_now = ($time_now+1) % 4;
            $success_click = 1;
        }
    }
    return @mat;
} 


# MAIN BODY
if ($ARGV[0]) {
    my @items = @ARGV;
    my $num_of_items = scalar @items;
    my @test = matrixize_anticlockwise( \@items, closest_factorization($num_of_items) );
    print_matrix_ad([@test]);
}


=pod

@items = (1..60);

 24 23 22 21 20 19 18 17 16 15
 25 46 45 44 43 42 41 40 39 14
 26 47 60 59 58 57 56 55 38 13
 27 48 49 50 51 52 53 54 37 12
 28 29 30 31 32 33 34 35 36 11
  1  2  3  4  5  6  7  8  9 10

=cut
