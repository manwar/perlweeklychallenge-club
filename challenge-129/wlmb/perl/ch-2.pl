#!/usr/bin/env perl
# Perl weekly challenge 129
# Task 2:  add linked lists
#
# See https://wlmb.github.io/2021/09/06/PWC129/#task-2-add-linked-lists
use warnings;
use strict;
use v5.12;
use List::Util qw(all);
use bigint; # to allow large lists
my @A=split /\s*->\s*/, shift @ARGV;
my @B=split /\s*->\s*/, shift @ARGV;
die "Usage: ./ch-2.pl l1 l2 with list arguments of the form \"dN...d2->d1->d0\""
    unless all {m/^\d$/} @A, @B;
my $A=join '', @A;
my $B=join '', @B;
my $length=@A-@B;
my $indent_A=$length<0?"   "x(-$length):"";
my $indent_B=$length>0?"   "x  $length :"";
say "Input: L1=$indent_A", join "->", @A;
say "       L2=$indent_B", join "->", @B;
say "Output:   ", join "->", split '', $A+$B;
