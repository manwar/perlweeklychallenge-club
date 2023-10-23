#!/usr/bin/env perl
use experimental qw/signatures/;
use Test2::V0;
plan 2;

is build_array([0,2,1,5,3,4]), [0,1,2,4,5,3];
is build_array([5,0,1,2,3,4]), [4,5,0,1,2,3];

sub build_array($arr) { [ @$arr[@$arr] ] }
