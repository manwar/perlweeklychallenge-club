#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;

# solution
sub get_major (@) {
    @_ == 0 and return -1;
    @_ == 1 and return $_[0];

    my @sorted  = sort @_;
    my $halflen = int .5 * @sorted;     # (halflen)gth
    my $pnum    = shift @sorted;        # (p)revious (num)ber
    my $pcnt    = 1;                    # (p)revious (c)ou(nt)

    my $result = -1;
    for my $cnum ( @sorted ) {
        if ( $pnum == $cnum ) {
            ++$pcnt > $halflen and ( $result = $cnum, last );
        }
        else {
            ( $pnum, $pcnt ) = ( $cnum, 1 );
        }
    }
    $result
}

# testing
sub unsort ( @ )  { sort { (-1,1)[(rand 1)+0.46] } @_ }
sub ssprintf ($$) { sprintf "%#$_[0]s", $_[1] }
sub map_ssprintf  { map { sprintf "%#$_[0]s", $_ } @_[1..$#_] }

sub print_count (@) {
    my $num   = shift;
    my $len   = shift;
    my $cnt = 0;
    my @count = map {  $_ == $num ?  ++$cnt : ' ' } @_;
    local $" = ' ';
    print "Count  (num:  @{[ssprintf $len,$num]}): @{[map_ssprintf $len,@count]}\n";
}


package main;

my $S = shift || 10;
my $ensure_major = int .5 + rand 1;
my $major_number = int rand $S;
my $half_length  = int .5 * $S;
my $L            = length   $S;

my @sample = unsort ( ( $major_number )  x  ( $half_length + 1),
                      (map{ int rand $S } 0.. $half_length - 1) );

$" = ',';
print "Sample (size: @{[ssprintf $L,$S]}): @{[map_ssprintf $L,@sample]}\n";


my $maybe_major = get_major @sample;
print "Output: $maybe_major";
$maybe_major != -1
    and ( print( "  where\n" ), print_count $maybe_major, $L, @sample )
    or print$/;
( $ensure_major and $maybe_major == 1)
    and ( print( "  however\n" ), print_count $major_number, $L, @sample );
