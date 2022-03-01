#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @s;
my @words = qw(
  PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP
  ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP LPER LPRE
  LEPR LRPE LREP
);

## We enumerate the combinations in "alphabetic" order
## Rather than returning an array - which uses extra
## memory we effectively have a generator giving the
## next combination...

sub next_comb {
  my( $i, $j );
  ( $s[$_] lt $s[$_+1] ) && ( $i = $_ ) for 0    .. @s-2;
  return unless defined $i;
  ( $s[$i] lt $s[$_]   ) && ( $j = $_ ) for $i+1 .. @s-1;
  @s[ $i, $j       ] = @s[ $j, $i               ];
  @s[ $i+1 .. @s-1 ] = @s[ reverse $i+1 .. @s-1 ];
  return join '',@s;
}

## "Proper" solution...
say '';
say 'Solution - with no assumptions about uniqueness/# missing:';
say '';

@s        = sort split //, 'PERL';
my %check = map { $_=>1 } @words;
$_ = join '', @s;
do { exists $check{$_} || say "  * $_" } while $_ = next_comb;

## Hack solution

say '';
say 'Solution - assuming uniqueness and one missing!';
say '';

my $r ='';
$r^=$_ for @words;
say "  * $r";

say '';


