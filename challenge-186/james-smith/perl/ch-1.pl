#!/usr/local/bin/perl
use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

## Simple code:
##
## We use a signature so that we can use arrays in call rather
## than references to arrays. The signature then converts the
## arrays in the call into references.
##
## Rather using a loop variable and select out of the two arrays
## we loop through 1 and use a pointer to loop through the
## other.

sub zip (\@\@) {
  my $c = 0;
  map { $_, $_[1][$c++] } @{$_[0]}
}

## Using a pointer for both arrays..
##
## This is the naive version where we have a counter and
## use it to index both arrays.
##
## Good as it is a single line...

sub zipt (\@\@) {
  map { $_[0][$_], $_[1][$_] } 0..@{$_[0]}-1;
}

## Golfed code:
##
## Now for the slightly off the wall one.  We loop through
## one array and shift off the other
##
## Here we abuse @_ to store the array - to avoid a `my`
## but it also means `shift @array` becomes just `shift`.

sub zipx (\@\@) {
  local($_,@_)=(shift,@{shift()});
  map{$_,shift}@$_
}

my @long  = 1..1000;
my @long2 = map {$_,$_} @long;
my @TESTS = (
#  [ [1,2,3],[4,5,6],[1,4,2,5,3,6] ],
#  [ [1,1,1],[2,2,2],[1,2,1,2,1,2] ],
#  [ [1,2,3,4,5,6,7,8,9],[11,12,13,14,15,16,17,18,19],
#    [1,11,2,12,3,13,4,14,5,15,6,16,7,17,8,18,9,19] ],
  [ [@long],[@long],[@long2] ],
);

say "   @{[ zip(  @{$_->[0]}, @{$_->[1]} ) ]}\n = @{[ zipt(  @{$_->[0]}, @{$_->[1]} ) ]}\n = @{[ zipx(  @{$_->[0]}, @{$_->[1]} ) ]}" for @TESTS;
is( "@{[ zip(  @{$_->[0]}, @{$_->[1]} ) ]}", "@{$_->[2]}" ) for @TESTS;
is( "@{[ zipt( @{$_->[0]}, @{$_->[1]} ) ]}", "@{$_->[2]}" ) for @TESTS;
is( "@{[ zipx( @{$_->[0]}, @{$_->[1]} ) ]}", "@{$_->[2]}" ) for @TESTS;

done_testing();

## Performance stats if we don't include the 1..1000 array.

#          Rate zipx zipt  zip
# zipx 331126/s   --  -0% -12%
# zipt 331126/s   0%   -- -12%
# zip  375940/s  14%  14%   --

## Performance stats if we include the 1..1000 array.

#          Rate zipt  zip zipx
# zipt   8403/s   -- -24% -26%
# zip   11050/s  31%   --  -3%
# zipx  11364/s  35%   3%   --

## If we look further - the break point where `zipx` is faster
## than `zip` is around an array length of 35...

cmpthese( 10_000, {
  'zip'  => sub { zip(   @{$_->[0]}, @{$_->[1]} ) for @TESTS },
  'zipt' => sub { zipt(  @{$_->[0]}, @{$_->[1]} ) for @TESTS },
  'zipx' => sub { zipx(  @{$_->[0]}, @{$_->[1]} ) for @TESTS },
});
