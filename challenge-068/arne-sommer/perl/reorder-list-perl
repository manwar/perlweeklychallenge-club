#! /usr/bin/env perl

use strict;
use List::SomeUtils qw/zip/;
use POSIX;
use feature 'say';

die "Please specify a list of values" unless @ARGV;

my $last   = $#ARGV;
my $half   = ceil($last / 2 -1);
my @first  = @ARGV[0 .. $half];
my @second = reverse(@ARGV[$half+1 .. $last]);

say join(" -> ", grep { defined $_ } zip(@first, @second));
