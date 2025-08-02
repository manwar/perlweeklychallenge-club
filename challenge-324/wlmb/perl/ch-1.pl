#!/usr/bin/env perl
# Perl weekly challenge 324
# Task 1:  2D Array
#
# See https://wlmb.github.io/2025/06/02/PWC324/#task-1-2d-array
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV >= 3;
    Usage: $0 R C D1 D2...
    to reshape the array (D1 D2...) into a matrix with
    R rows and C columns
    FIN
my ($rows, $cols, @array)=@ARGV;
die "Number of elements should equal RxC" unless $rows*$cols==@array;
my $array=pdl(@array);
my $reshaped=$array->copy->reshape($cols, $rows);
say "rows=$rows, cols=$cols, array= $array -> $reshaped";
