#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util qw< sum min >;

my @triangle = map { [split m{,}mxs] } @ARGV;
say triangle_sum_path(@triangle);

sub triangle_sum_path (@triangle) { sum map { min $_->@* } @triangle }
