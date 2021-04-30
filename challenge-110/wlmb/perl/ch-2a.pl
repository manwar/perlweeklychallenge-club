#!/usr/bin/env perl
# Perl weekly challenge 110
# Task 2: Transpose file
#
# CSV version
# See https://wlmb.github.io/2021/04/27/PWC110/#task-2-transpose-file
use strict;
use warnings;
use v5.12;
use List::Util qw(max);
use Text::CSV qw(csv);
my $input=csv(in=>*ARGV);
my $Ncols=max map {scalar @{$input->[$_]}} @$input-1;
my $transposed=[map {my $c=$_; [map {$input->[$_][$c]} 0..@$input-1]} 0..$Ncols-1];
csv(in=>$transposed, out=>*STDOUT, eol=>$/);
