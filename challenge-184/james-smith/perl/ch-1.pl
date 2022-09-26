#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [ qw(ab1234 cd5678 ef1342) ], '001234 015678 021342' ],
  [ [ qw(pq1122 rs3334)        ], '001122 013334'        ],
);

is( join( ' ', seq_number_substr(@{$_->[0]})), $_->[1] ) foreach @TESTS;
is( join( ' ', seq_number_subrep(@{$_->[0]})), $_->[1] ) foreach @TESTS;
is( join( ' ', seq_number_regexp(@{$_->[0]})), $_->[1] ) foreach @TESTS;
done_testing();

cmpthese( 1_000_000, {
  'substr' => sub { seq_number_substr(@{$_->[0]}) foreach @TESTS },
  'subrep' => sub { seq_number_subrep(@{$_->[0]}) foreach @TESTS },
  'regexp' => sub { seq_number_regexp(@{$_->[0]}) foreach @TESTS },
});

sub seq_number_substr { my $s = '00'; return map { ($s++).substr $_,2 }     @_ }
sub seq_number_subrep { my $s = '00'; return map { substr $_,0,2,$s++; $_ } @_ }
sub seq_number_regexp { my $s = '00'; return map { s/../$s++/re }           @_ }

