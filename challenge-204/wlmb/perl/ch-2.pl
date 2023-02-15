#!/usr/bin/env perl
# Perl weekly challenge 204
# Task 2:  Reshape Matrix
#
# See https://wlmb.github.io/2023/02/13/PWC204/#task-2-reshape-matrix
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV==3;
    Usage: $0 M r c
    to convert matrix M (a string using PDL's notation)
    to a matrix with r rows, c columns
    FIN
my $M=pdl shift;
my ($rows, $cols)=@ARGV;
my $nelem=$M->nelem; # total number of elements
my $desired=$rows*$cols;
say("$M cannot be reshaped to $rows rows and $cols columns: 0"), exit
    unless $desired==$nelem;
my $N=$M->copy;
$N->reshape($cols) if $rows==1;        # 1D row vector
$N->reshape($cols, $rows) if $rows!=1; #2D matrix
say "$M as $rows x $cols matrix becomes $N"
