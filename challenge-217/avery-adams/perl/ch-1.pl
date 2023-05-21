#!/usr/bin/perl

use strict;
use v5.24;

my @matrix1 = ([3, 1, 2], [5, 2, 4], [0, 1, 3]);
my @list1;

foreach (@matrix1) {map {push @list1, $_} @{$_}}
@list1 = sort @list1;
say $list1[2];

my @matrix2 = ([2, 1], [4, 5]);
my @list2;

foreach (@matrix2) {map {push @list2, $_} @{$_}}
@list2 = sort @list2;
say $list2[2];

my @matrix3 = ([1, 0, 3], [0, 0, 0], [1, 2, 1]);
my @list3;

foreach (@matrix3) {map {push @list3, $_} @{$_}}
@list3 = sort @list3;
say $list3[2];
