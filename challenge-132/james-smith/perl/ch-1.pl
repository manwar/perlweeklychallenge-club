#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Date::Calc qw( Today Delta_Days Add_Delta_Days );

my @TODAY = @ARGV ? split m{/}, $ARGV[0]: Today;

my @TESTS = (
  [ '2021/09/18', '2021/09/14-2021/09/26' ],
  [ '1975/10/10', '1929/10/27-2067/09/05' ],
  [ '1967/02/14', '1912/07/08-2076/04/30' ],
);

is( join( '-', @{mirror_days($_->[0])} ), $_->[1] ) foreach @TESTS;

done_testing();

sub mirror_days {
  my $d = Delta_Days( @TODAY, split m{/}, $_->[0] ); ## Days between today and birthday
  return  [
    sprintf( '%04d/%02d/%02d', Add_Delta_Days( @bd,     $d )),
    sprintf( '%04d/%02d/%02d', Add_Delta_Days( @TODAY, -$d )),
  ];
}
