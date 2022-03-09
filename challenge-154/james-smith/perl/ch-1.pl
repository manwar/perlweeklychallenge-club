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

# We enumerate the permutations in "alphabetic" order
# Rather than returning an array - which uses extra
# memory we effectively have a generator giving the
# next permutation... In this case permutation
# are equivalent as all letters are unique...

# This is a standard algorithm - so I won't include
# the explanation as it can be looked up, basically will
# generate
#        ELRP EPLR EPRL ERLP ERPL
#   LEPR LERP LPER LPRE LREP LRPE
#   PELR PERL PLER PLRE PREL PRLE
#   RELP REPL RLEP RLPE RPEL RPLE

sub next_perm {
  my( $i, $j );
  ( $s[$_] lt $s[$_+1] ) && ( $i = $_ ) for 0    .. @s-2;
  return unless defined $i;
  ( $s[$i] lt $s[$_  ] ) && ( $j = $_ ) for $i+1 .. @s-1;
  @s[ $i, $j       ] = @s[ $j, $i               ];
  @s[ $i+1 .. @s-1 ] = @s[ reverse $i+1 .. @s-1 ];
  return join '',@s;
}

# "Proper" solution...
say '';
say 'Solution - with no assumptions about uniqueness/# missing:';
say '';

my $w = join '', @s = sort split //, 'PERL';
my %check = map { $_=>1 } @words;
do { exists $check{ $w } || say "  * $w"; } while $w = next_perm;

# We have to use "do/while" here rather than just "while" to
# make sure we include the first term, o/w we would miss it
# out with the update $_ = next_perm happening first

$w = join '', @s = sort split //, 'PERL';
my @sorted = sort @words;

say '';
say 'Solution - with no assumptions about # missing - sorted strings (unique)';
say '';

do { $w lt $sorted[0] ? say "  * $w" : shift @sorted } while $w = next_perm;

## "Hack" solution

say '';
say 'Solution - assuming uniqueness and one missing!';
say '';

my $r ='';
$r^=$_ for @words;
say "  * $r";

# You might ask how this works! Every time you XOR a word. It
# flips all the bits in that character. Now each word should
# appear 6 times - but the missing word only occurs 5 times.
# So the 6 times a letter appears are cancelled out as
# A^B^B = A, so B^B^B^B^B^B = ''
# The ones appearing only 5 times are not as B^B^B^B^B = B.

say '';


