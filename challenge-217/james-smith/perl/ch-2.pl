#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);
use Data::Dumper qw(Dumper);

my @TESTS = (
 [ [1,23],231],
 [ [10,3,2],3210],
 [ [31,2,4,10] ,431210],
 [ [5,11,4,1,2], 542111],
 [ [1,10],110 ],
 [ [1,10,110,9,90,900],'990900111010' ],
 [ [900,1,9,10,90,110],'990900111010' ],
);


sub max_number      { join '', sort { $b.$a cmp $a.$b } @_ }
sub max_number_n    { join '', sort { $b.$a <=> $a.$b } @_ }

is( max_number( @{$_->[0]} )       , $_->[1] ) for @TESTS;
is( max_number_n( @{$_->[0]} )       , $_->[1] ) for @TESTS;
done_testing();

cmpthese( 5_000_000, {
  'cmp' => sub { max_number(    @{$_->[0]} ) for @TESTS },
  '<=>' => sub { max_number_n(  @{$_->[0]} ) for @TESTS },
});

