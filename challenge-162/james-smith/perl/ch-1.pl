#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ '978-0-306-40615-7', 1, 7 ],
  [ '978-3-16-148410-0', 1, 0 ],
  [ '978-0-306-40615-3', 0, 7 ],
  [ '978-3-16-148410-4', 0, 0 ],
  [ '978-8-3516-1020-8', 1, 8 ],
  [ '978-0-2788-4569-5', 1, 5 ],
  [ '978-4-0677-1190-1', 1, 1 ],
  [ '978-1-6672-1485-6', 1, 6 ],
  [ '978-4-0881-0106-4', 1, 4 ],
  [ '978-6-6163-6174-2', 1, 2 ],
  [ '978-9-0613-4792-7', 1, 7 ],
  [ '978-3-0302-4843-7', 1, 7 ],
  [ '978-0-1906-8107-4', 1, 4 ],
  [ '978-7-5021-7110-0', 1, 0 ],
);

is( validate_isbn13($_->[0]) || 0, $_->[1] ) foreach @TESTS;
is( checksum_isbn13($_->[0]) || 0, $_->[2] ) foreach @TESTS;

done_testing();

sub validate_isbn13 {
  my @p = ( my $s = 0, grep {/\d/} split //, $_[0] );
  $s += 3*shift(@p) + shift @p while @p;
  !($s%10);
}

sub checksum_isbn13 {
  my($s,@p) = ( 0, @{[grep {/\d/} split //, $_[0]]}[0..11] );
  $s -= shift(@p) + 3*shift @p while @p;
  $s%10;
}

