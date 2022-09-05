#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 0, 1 ],
);

my $in = q(All he could think about was how it would all end. There was
    still a bit of uncertainty in the equation, but the basics
    were there for anyone to see. No matter how much he tried to
    see the positive, it wasn't anywhere to be seen. The end was
    coming and it wasn't going to be pretty.);
say parse($in);

sub parse {
  ( join '. ',             ## join back paragraph
               ## sort into order first case insensitive
               ## duplicate words sorted upper case first!
    map { join ' ', sort { lc($a) cmp lc($b) || $a cmp $b } split }
    split /[.]\s*/, $_[0]  ## Split into sentences
  ).'.'                    ## We have to add the trailing dot
}

