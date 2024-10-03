#!/usr/bin/env perl

# Challenge 170
#
# Task 2: Kronecker Product
# Submitted by: Mohammad S Anwar
#
# You are given 2 matrices.
#
# Write a script to implement Kronecker Product on the given 2 matrices.
#
# For more information, please refer wikipedia page.
#
# For example,
#
# A = [ 1 2 ]
#     [ 3 4 ]
#
# B = [ 5 6 ]
#     [ 7 8 ]
#
# A x B = [ 1 x [ 5 6 ]   2 x [ 5 6 ] ]
#         [     [ 7 8 ]       [ 7 8 ] ]
#         [ 3 x [ 5 6 ]   4 x [ 5 6 ] ]
#         [     [ 7 8 ]       [ 7 8 ] ]
#
#       = [ 1x5 1x6 2x5 2x6 ]
#         [ 1x7 1x8 2x7 2x8 ]
#         [ 3x5 3x6 4x5 4x6 ]
#         [ 3x7 3x8 4x7 4x8 ]
#
#       = [  5  6 10 12 ]
#         [  7  8 14 16 ]
#         [ 15 18 20 24 ]
#         [ 21 24 28 32 ]

use Modern::Perl;

# current input line in $_
sub parse_matrix {
    my @a;
    s/^\s*\w+\s*=\s*// or die "assignment expected: $_";
    while (defined $_) {
        /\s*\[([\s\d]+)\]\s*$/ or last;
        my @row = split(' ', $1);
        push @a, \@row;
        $_=<>;
    }
    return @a;
}

sub parse_input {
    $_ = "";
    $_=<> while /^\s*$/;
    my @a = parse_matrix();
    $_=<> while /^\s*$/;
    my @b = parse_matrix();
    return \@a, \@b;
}

sub kronecker_product {
    my($a, $b) = @_;
    my $wa = @{$a->[0]}; my $ha = @$a;
    my $wb = @{$b->[0]}; my $hb = @$a;
    my @prod;
    for my $ar (0..$ha-1) {
        for my $ac (0..$wa-1) {
            for my $br (0..$hb-1) {
                for my $bc (0..$wb-1) {
                    my $tr = $ar*$hb + $br;
                    my $tc = $ac*$wb + $bc;
                    $prod[$tr] ||= [];
                    $prod[$tr][$tc] = $a->[$ar][$ac] * $b->[$br][$bc];
                }
            }
        }
    }
    return @prod;
}

sub print_matrix {
    my(@a) = @_;
    for (@a) {
        print "[ ";
        for (@$_) {
            printf("%2d ", $_);
        }
        print "]\n";
    }
}

print_matrix(kronecker_product(parse_input()));
