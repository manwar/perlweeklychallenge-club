# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
#
#         FILE: SubstringIterator.t
#
#  DESCRIPTION: Unit test for SubstringIterator
#===============================================================================

use v5.36;

use Test2::V0;

use SubstringIterator;

my $ssi = SubstringIterator->new("a");
isa_ok( $ssi, [ qw(SubstringIterator) ] );

my @ret;
@ret = $ssi->next(); is ( \@ret, [ '', 'a', '' ], "Length one first");
@ret = $ssi->next(); is ( \@ret, [ undef,undef,undef ], "Length one last");

$ssi = SubstringIterator->new("abc");
@ret = $ssi->next(); is ( \@ret, [ '',   'abc', ''   ], "Length 3 first");
@ret = $ssi->next(); is ( \@ret, [ '',   'ab',  'c'  ], "Length 3 2");
@ret = $ssi->next(); is ( \@ret, [ 'a',  'bc',  ''   ], "Length 3 3");
@ret = $ssi->next(); is ( \@ret, [ '',   'a',   'bc' ], "Length 3 4");
@ret = $ssi->next(); is ( \@ret, [ 'a',  'b',   'c'  ], "Length 3 5");
@ret = $ssi->next(); is ( \@ret, [ 'ab', 'c',   ''   ], "Length 3 6");
@ret = $ssi->next(); is ( \@ret, [ undef,undef,undef ], "Length one last");


done_testing();
