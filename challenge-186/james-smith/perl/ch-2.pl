#!/usr/local/bin/perl

use strict;
use utf8;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
binmode(STDOUT, "encoding(UTF-8)");

## Firstly we get information about the UNICODE blocks
##
## `%blocks` is a hash whose key is the numeric value
## of the first character in the block `ord($ch)`.
## the second is a series of letter substitutions for
## that block.
##
## If the value in array is `?` then we assume there is
## no direct mapping.

my %blocks = code_blocks();

## This might be seen as nasty code!!
##
## We split the string into chunks
## we assume it is a UTF-8 string.
##
## We loop through each block and see if the character
## would be in that block - if it is we grab the
## mapped version of the character - this is the map
##
## We then `grep` out any `?` character
##
## We then add the original symbol to the list...
##
## There will be at most one entry from the grep
##
## So therefore the array will be either
##
##   [ mapped, original ] or [ original ]
##
## So getting the zero-th element we have the mapped
## character if there is one or the original character
## if there isn't

sub plain { join '', map { my $t = ord $_;
  ( grep( { $_ ne '?' }
      map { $t >= $_ && $t-$_ < @{$blocks{$_}}
          ? $blocks{$_}[$t-$_] : () }
      keys %blocks
    ), chr $t )[0]
} split //, pop }

## These strings are UTF-8 as we have a `use utf8;` statement at
## the start of the code..
##
## We know output is going to be UTF-8 ans we changed the *binmode*
## of STDOUT to be UTF-8

my @TESTS = (
  [ 'ÃÊÍÒÙ!',              'AEIOU!' ],
  [ 'âÊíÒÙ',               'aEiOU'  ],
  [ 'Ƭȟȩ Ẇḕȅǩȴƴ Ćħąỻḝṅḡể', 'The Weekly Challenge' ],
);
say sprintf '-%30s => %s', $_->[0], plain( $_->[0] ) for @TESTS;

is( plain($_->[0]), $_->[1] ) for @TESTS; done_testing();

sub code_blocks {
 192 => [qw(
          A A A A A A A C E E E E I I I I TH N O O O O O x O U U U U Y TH SS
          a a a a a a a c e e e e i i i i th n o o o o o ? o u u u u y th y
          A a A a A a C c C c C c C c D d D d E e E e E e E e E e G g G g
          G g G g H h H h I i I i I i I i I i IJ ij J j K k k L l L l L l L

          l L l N n N n N n n NG ng O o O o O o OE oe R r R r R r S s S s S s
          S s T t T t T t U u U u U u U u U u U u W w Y y Y Z z Z z Z z S
          b B B b ? ? O C c D D D d d E ? E F f G G HV I I K k l l M N n O
          O o OI oi P p YR ? ? ? ? t T t T U u U V Y y Z z ? ? ? ? ? ? ? ? ?

          ? ? ? ? DZ Dz dz LJ Lj lj NJ Nj nj A a I i O o U u U u U u U u U u E A a
          A a AE ae G g G g K k O o O o ? ?  j DZ Dz gz G g ? ? N n A a AE ae O O
          A a A a E e E e I i I i O o O o R r R r U u U u S s T t ? ? H h
          N d OU ou Z z A a E e O o O o O o O o Y y l n t j DB QP A C c L T s

          z ? ? B U V E e J j Q q R r Y y a a a b o c d d e e e e e e e j
          g g g ? ? h h ? i i i l l l ? m m m n n n o oe ? ? r r r r r r r
          r r s ? j ? ? t t u u v v w y y z z ? ? ? ? ? c ? b e g h j k l
          q ? ? dz ? dz ts ? tc ? ls lz ? ? h h)],
  7680 => [qw(
          A a B b B b B b C c D d D d D d D d D d E e E e E e E e E e F f
          G g H h H h H h H h H h I i I i K k K k K k L l L l L l L l M m
          M m M m N n N n N n N n O o O o O o O o P p P p R r R r R r R r
          S s S s S s S s S s T t T t T t T t U u U u U u U u U u V v V v

          W w W w W w W w W w X x X x Y y Z z Z z Z z t h w y a s s s SS d
          A a A a A a A a A a A a A a A a A a A a A a A a E e E e E e E e

          E e E e E e E e I i I i O o O o O o O o O o O o O o O o O o O o
          O o O o U u U u U u U u U u U u U u Y y Y y Y y Y y LL ll V v Y y)],
## Latin extended-C
  11360 => [qw(
          L l L P R a t H h K k Z z D M A D v W w v ? ? ? e ? o e j v S Z )],
## Latin extended-E
  43824 => [qw(
          a ae e e e f g l l l m n n ? ? c oe oe ee co co y r r r r r r r s n n
          m m n x x x x x x x y ? ? ? ? ? lb ie ce uo a)],
}


