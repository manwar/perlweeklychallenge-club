#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

##----------------------------------------------------------------------
## Three different versions of code..
##
##  * Using reverse/regex
##  * Using maths/regex   speed gain ~ 50%
##  * Using maths/maths   speed gain ~ 60% ; total gain ~ 130%
##----------------------------------------------------------------------


# use reverse and regex...
sub reversible_regex {
  grep { ($_+reverse) =~ m{^[13579]{2}$} } 10..99;
}

sub reversible_maths {
  my $q;
  grep { ($q = ($_+reverse) )%2 && int($q/10)%2 } 10..99;
}

my $ans = '10 12 14 16 18 21 23 25 27 30 32 34 36 41 43 45 50 52 54 61 63 70 72 81 90';
my @res = (
  [ 'regex'   => "@{[reversible_regex()]}"     ],
  [ 'maths'   => "@{[reversible_maths()]}"      ],
);

say sprintf '%10s: %5s : %s', $_->[0], $_->[1] eq $ans ? 'pass' : 'fail', $_->[1] for @res;

cmpthese( 20_000,{
  'maths'   => sub { reversible_maths },
  'regex'   => sub { reversible_regex },
});

