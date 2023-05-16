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

is ( $ssi->next(), "a", "Length one first");
is ( $ssi->next(), undef, "Length one last");

done_testing();
