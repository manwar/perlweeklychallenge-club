#!/usr/bin/perl
use strict;
use warnings;
#use Test::Deep;
#use Test::More tests => 4;
# Task statement:
# You are given m x n matrix of positive integers.
# Write a script to print spiral matrix as list.
# Usage: ch-2.pl [matrix height] [matrix width] [matrix entries]
# Example
#  input: $ ch-2.pl 2 2 A B C D
# output: A, B, D, C 

sub print_matrix {
    my @mat = @{$_[0]};  
    my $M = scalar @mat;
    my $N = scalar @{$mat[0]};
    for my $j (0..$M-1) {
        print "[", join(", ", @{$mat[$j]}), "]" ;
        print "\n";
    }
}



sub flat {
    my $clockwise = 1; # set this as "undef" for anti-clockwise case
    my @ans;
    my @mat = @{$_[0]};  
    my $M = scalar @mat;
    my $N = scalar @{$mat[0]};

    my @helper_mat;
    push @helper_mat, [("0") x $N] for (0..$M-1);

    my @row_dir = (  0, +1,  0, -1 );
    my @col_dir = ( +1,  0, -1,  0 );

    my ($r, $c) = ( 0 , 0 );
    push @ans, ${$mat[$r]}[$c];
    ${$helper_mat[$r]}[$c] = 1;

# clockwise traverse of the outermost part of the matrix
    my @numbering = (
        [1..$N-1], 
        [$N..$N+$M-2], 
        [$N+$M-1..$N+$M+$N-3], 
        [$N+$M+$N-2..($M-1)*2+($N-1)*2-1]
    );

# ========= begin: anticlockwise setting =============
    if (!$clockwise) {
        @row_dir = map {$_ = -$_} (reverse @row_dir);
        @col_dir = map {$_ = -$_} (reverse @col_dir);
        @numbering = (
            [1..$M-1], 
            [$M..$N+$M-2], 
            [$N+$M-1..$N+$M+$M-3], 
            [$N+$M+$M-2..($M-1)*2+($N-1)*2-1]
        );

    }
# ========= end: anticlockwise setting =============

    for my $q (0..3) {
        for (@{$numbering[$q]}) {
            $r += $row_dir[$q];
            $c += $col_dir[$q];
            push @ans, ${$mat[$r]}[$c];
            ${$helper_mat[$r]}[$c] = 1;
        }
    }

    my $time_now = 3;
    my $success_click = undef;
    my $count = ($M-1)*2+($N-1)*2;
    while ($count < $M*$N) {
        if ($success_click) {
            $r += $row_dir[$time_now];
            $c += $col_dir[$time_now];
            if (${$helper_mat[$r]}[$c] == 0) {
                push @ans, ${$mat[$r]}[$c];
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
    return \@ans;
}

# ===== begin "matrixize" =====================
# additional function  matrixize  ;clockwise only

sub matrixize {  
    my @list = @{$_[0]};
    my $M = $_[1];
    my $N = $_[2];
    my @mat;
    my @helper_mat;
    push @helper_mat, [("0") x $N] for (0..$M-1);

    my @row_dir = (  0, +1,  0, -1 );
    my @col_dir = ( +1,  0, -1,  0 );

    my ($r, $c) = ( 0 , 0 );
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
            if (${$helper_mat[$r]}[$c] == 0) {
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
# ===== end "matrixize" =======================

#================= begin "matrixize" test =====
=pod
my @test = matrixize([1..60], 6, 10);
print_matrix([@test]);
print "test end\n";
=cut
#  expected output:
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# [28, 29, 30, 31, 32, 33, 34, 35, 36, 11]
# [27, 48, 49, 50, 51, 52, 53, 54, 37, 12]
# [26, 47, 60, 59, 58, 57, 56, 55, 38, 13]
# [25, 46, 45, 44, 43, 42, 41, 40, 39, 14]
# [24, 23, 22, 21, 20, 19, 18, 17, 16, 15]


#======================== end "matrixize" test =

if ($ARGV[0]) {
    my @f = @ARGV;
    my $M = shift @f;
    my $N = shift @f;
    my @matrix = ();
    die "Input Parameters Error" unless scalar @f == $M*$N;
    for my $j (0..$M-1) {
        push @matrix , [ @f[$N*$j..$N*$j+$N-1] ];
    }

    print_matrix([@matrix]);
    print join ", ", @{flat([@matrix])};
    print "\n";
}

=pod
cmp_deeply(
    flat([[  1,  2,  3],
    [  4, 5,  6,],
    [  7, 8, 9,  ]]),
    [ 1, 2, 3, 6, 9, 8, 7, 4, 5  ]
, "Example 1");
cmp_deeply(
    flat([[  1,  2,  3,  4 ],
    [  5,  6,  7,  8 ],
    [  9, 10, 11, 12 ],
    [ 13, 14, 15, 16 ]]), 
    [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]
, "Example 2");
cmp_deeply(
    flat([[  1,  2,  3],
    [  4, 5,  6,]]),
    [ 1, 2, 3, 6, 5, 4 ]
, "small test case");

cmp_deeply(
    flat([
    [ 2, 3, 5, 7],
    [11,13,17,19],
    [23,29,31,37],
    [41,43,47,53],
    [59,61,67,71]])
, [2, 3, 5, 7, 19, 37, 53, 71, 67, 61, 59,
    41, 23, 11, 13, 17, 31, 47, 43, 29]
, "prime numbers 5 x 4");
=cut
