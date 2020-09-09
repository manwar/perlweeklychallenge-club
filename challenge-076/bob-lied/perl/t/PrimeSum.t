# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: Task1.t
# DESCRIPTION: Unit test for Task1
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;

use lib "lib";
use PrimeSum qw/_loadPrimeList/;

my $task = PrimeSum->new(15);

my $primeRef = _loadPrimeList(15, "t/primes-for-testing.txt");
is( $primeRef, [ 13, 11, 7, 5, 3, 2], "load primes descending");

my $N;
my $result;
my $list;

$N = 2;
($result, $list) = PrimeSum->new($N)->run();
is( $result, 1,          "Min for prime $N" );
is( $list,   [  2 ],     "List for prime $N" );

$N = 4;
($result, $list) = PrimeSum->new($N)->run();
is( $result, 2,          "Min for prime $N" );
is( $list,   [  2, 2 ],  "List for prime $N" );

$N = 17;
($result, $list) = PrimeSum->new($N)->run();
is( $result, 1,         "Min for prime $N" );
is( $list,   [ 17 ],    "List for prime $N" );

$N = 15;
($result, $list) = $task->run();
is( $result, 2,         "Min for $N" );
is( $list,   [ 13, 2 ], "List for $N" );

$N = 27;
($result, $list) = PrimeSum->new($N)->run();
is( $result, 3,         "Min for $N" );
is( $list,   [ 23, 2, 2 ], "List for $N" );

$N = 51;
($result, $list) = PrimeSum->new($N)->run();
is( $result, 3,         "Min for $N" );
is( $list,   [ 47, 2, 2 ], "List for $N" );

done_testing();
