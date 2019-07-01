#!/usr/bin/env perl

use v5.24;
use strict;
use warnings;
use feature qw(say state signatures);
no warnings "experimental::signatures";
use Memoize;
use List::Util qw(first);

# Write a script to generate Van Eck’s sequence starts with 0. For more
# information, please check out wikipedia page. This challenge was proposed by
# team member Andrezgz.
 
# Use Memoize to cache intermediate values in this function
memoize('van_eck_seq');

=over

=item get_workflow_type_row($n, $init = 0) : @sequence

Return a list of the first $n+1 terms in van Eck's sequence.
Supplying a value for $init changes the initial (0th) term.
By default, $init = 0.

=back

=cut
sub van_eck_seq ( $n, $init = 0 ) {

    # Base case. It should always be $init followed
    # by 0, given the definition.
    return ( $init, 0 ) if ( $n == 0 );

    my @seq = van_eck_seq( $n - 1, $init );
    my $m   = first { $seq[$_] == $seq[$n] } reverse( 0 .. ( $n - 1 ) );
    my $val = ( defined $m ) ? ( $n - $m ) : 0;

    return @seq, $val;
}

local $, = ", ";
say van_eck_seq(10);
