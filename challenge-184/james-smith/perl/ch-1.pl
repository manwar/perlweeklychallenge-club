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

is( join( ' ', seq_no_substr(@{$_->[0]})), $_->[1] ) foreach @TESTS;
is( join( ' ', seq_no_sprint(@{$_->[0]})), $_->[1] ) foreach @TESTS;
is( join( ' ', seq_no_number(@{$_->[0]})), $_->[1] ) foreach @TESTS;
is( join( ' ', seq_no_subrep(@{$_->[0]})), $_->[1] ) foreach @TESTS;
is( join( ' ', seq_no_regexp(@{$_->[0]})), $_->[1] ) foreach @TESTS;
done_testing();

cmpthese( 1_000_000, {
  'substr' => sub { seq_no_substr(@{$_->[0]}) foreach @TESTS },
  'sprint' => sub { seq_no_sprint(@{$_->[0]}) foreach @TESTS },
  'number' => sub { seq_no_number(@{$_->[0]}) foreach @TESTS },
  'subrep' => sub { seq_no_subrep(@{$_->[0]}) foreach @TESTS },
  'regexp' => sub { seq_no_regexp(@{$_->[0]}) foreach @TESTS },
});

sub seq_no_regexp { my $s = '00'; map { s/../$s++/re }                      @_ }
sub seq_no_subrep { my $s = '00'; map { substr $_, 0, 2, $s++; $_ }         @_ }
sub seq_no_sprint { my $s = 0;    map { sprintf('%02d',$s++). substr $_,2 } @_ }
sub seq_no_number { my $s = 0;    map { (($s<10)?'0':'').$s++.substr $_,2 } @_ }
sub seq_no_substr { my $s = '00'; map { $s++ . substr $_,2 }                @_ }

