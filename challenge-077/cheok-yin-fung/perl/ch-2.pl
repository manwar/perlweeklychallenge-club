#!/usr/bin/perl
# Perl Weekly Challenge #077 Task 2 Lonely X
# task statement: 
# You are given m x n character matrix 
# consists of O and X only.
# Write a script to count the total number of X 
# surrounded by O only. 
# Print 0 if none found.
# Usage: ch-2.pl $m $n [terms on the matrix, 
#           from a_1_1, a_1_2, a_1_3 to a_m_n]
#
# Test for Official Example 2 : 
# ch-2.pl 4 4  O O X O X O O O X O O X O X O O

# update on 14th Sep (after the deadline): fix bugs on subrountine detect


use strict;
use warnings;

unless (@ARGV) {die "No arguments given! I need:
\$m \$n a_1_1 a_1_2 a_1_3 .. a_m_n"}

my @matrix = ();

my $m = shift @ARGV;

my $n = shift @ARGV;

for my $colnum (1..$m) {
    $matrix[$colnum-1] = [ @ARGV[$n*($colnum-1)..$n*$colnum-1] ];
}

=pod
#Here are some test cases;
my @matrix = ( ["O", "O" , "X"], ["X", "O", "O"], 
                  ["X", "O", "O"]) ; #example 1
($m, $n) = (3, 3)

my @matrix = ( ["O", "X" , "X", "O"], ["X", "O", "O", "X"], 
                                      ["O", "O", "O", "O"]) ; 
($m, $n) = (3, 4);

my @matrix = ( ["O", "X" , "O"], ["X", "O", "O"], 
               ["O", "X", "O" ], ["O", "O", "O"], ["O", "X", "O"]) ; 
($m, $n) = (5, 3)

my @matrix = ( ["O", "X" , "O", "O"], ["X", "O", "X", "O"],
                                      ["O", "O", "O","O" ]) ; 
($m, $n) = (3, 4);
=cut

print_matrix(\@matrix);

sub detect {
    my $segment = join "", @_;
#    $segment =~ s/XI/II/g;          # delete on 14th Sep
#    $segment =~ s/IX/II/g;          # delete on 14th Sep
#    $segment =~ s/XX/II/g;          # delete on 14th Sep
    $segment =~ s/XX/II/g;          # add on 14th Sep
    $segment =~ s/XI/II/g;          # add on 14th Sep
    $segment =~ s/IX/II/g;          # add on 14th Sep
    return split //, $segment;
}

for my $i (0..$m-1) {
    @{$matrix[$i]} = detect @{$matrix[$i]};
}

for my $j (0..$n-1) {
    my @u = detect map {${$matrix[$_]}[$j]} (0..$m-1);    
    ${$matrix[$_]}[$j] = $u[$_] for (0..$m-1);
}

sub xyreverse {
    my @mat = @{$_[0]};
    my @newmat = ();
    my $t_xlen = scalar @{$mat[0]};
    my $t_ylen = scalar @mat;
    for my $y (0..$t_ylen-1) {
        for my $x (0..$t_xlen-1) {
            ${$newmat[$x]}[$y] = ${$mat[$y]}[$x];
        }
    }
    return \@newmat;
}

@matrix = @{diagonal_operation(\@matrix)};

sub diagonal_operation {
    my @mat = @{$_[0]};
    my $t_ylen = scalar @mat;
    my $t_xlen = scalar @{$mat[0]};
    if ($t_xlen >= $t_ylen) {
        my $t_diff = $t_xlen - $t_ylen;
        my $t_limit = $t_ylen;
        for my $c (0..$t_diff) {
            my @u = detect
                    (map {${$mat[$_]}[$c+$_]} (0..$t_ylen-1)) ;
            ${$mat[$_]}[$c+$_] = $u[$_] for (0..$t_ylen-1);
        }

        for my $d (0..$t_limit-2) {
            my @u = detect
                (map {${$mat[$_]}[$t_diff+$d+1+$_]} (0..$t_limit-$d-2)) ;
            ${$mat[$_]}[$t_diff+$d+1+$_] = $u[$_] for (0..$t_limit-$d-2) ;
            my @v = detect
                (map {${$mat[$d+1+$_]}[$_]} (0..$t_limit-$d-2)) ;
            ${$mat[$d+1+$_]}[$_] = $v[$_] for (0..$t_limit-$d-2) ;
        }
        
        return \@mat;
    }
    else {
        return xyreverse diagonal_operation(xyreverse(\@mat));
    }
}

sub vertical_reflection {
    my @mat = @{$_[0]};
    my @newmat;
    my $t_xlen = scalar @{$mat[0]};
    my $t_ylen = scalar @mat;
    for my $i (0..$t_ylen-1) {
        @{$newmat[$i]} = ();
        for my $j (0..$t_xlen-1) {
            ${$newmat[$i]}[$j] = ${$mat[$i]}[-1-$j];
        }
    }
    return \@newmat;
}

#find antidiagonal
@matrix = @{vertical_reflection diagonal_operation
             vertical_reflection(\@matrix)};

sub print_matrix {
    my @mat = @{$_[0]};
    my $t_xlen = scalar @{$mat[0]};
    my $t_ylen = scalar @mat;
    for my $i (0..$t_ylen-1) {
        print "[ ";
        for my $j (0..$t_xlen-1) {
            print ${$mat[$i]}[$j], " ";
        }
        print "]\n";
    }
}

print "\n------------\n";

my $count = 0;

for my $row (0..$m-1) {
    for my $col (0..$n-1) {
        if (${$matrix[$row]}[$col] eq "X") {
            $count++;
        }
    }
}

print $count, "\n";
