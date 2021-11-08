#!/usr/bin/env perl
# Disjointed Sets

use strict;
use warnings;
use Test::More;

my @S1 = ( 1, 2, 5, 3, 4 );
my @S2 = ( 4, 6, 7, 8, 9 );
# Output: 0 as the given two sets have common member 4.

my @S3 = ( 1, 3, 5, 7, 9 );
my @S4 = ( 0, 2, 4, 6, 8 );
# Output: 1 as the given two sets do not have common member.

ok( are_sets_disjointed( \@S1, \@S2 ) == 0,
    'Output: 0 as the given two sets have common member 4' );
ok( are_sets_disjointed( \@S3, \@S4 ) == 1,
    'Output: 1 as the given two sets do not have common member' );
done_testing();

sub are_sets_disjointed {
    my $set_ref1 = shift;
    my $set_ref2 = shift;
    my @set1     = @{$set_ref1};
    my @set2     = @{$set_ref2};
    my %union;
    map { $union{$_} = 1 } @set1;
    map { $union{$_} = 1 } @set2;
    return ( scalar keys %union ) == ( scalar @set1 + scalar @set2 );
}
