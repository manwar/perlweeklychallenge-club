#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util qw(any zip);

sub main ( $str1, $str2 ) {
    my @order   = ( $str1 =~ /(\d+)/g );
    my @friends = ( $str2 =~ /(\d+)/g );

    # Validate input. Order contains 1 .. n
    if ( any { $_->[0] != $_->[1] }
        zip( [ 1 .. $#order + 1 ], [ sort { $a <=> $b } @order ] ) )
    {
        die "The order list is invalid\n";
    }

    # Friends is in increasing order
    if ( grep { $friends[ $_ - 1 ] >= $friends[$_] } ( 1 .. $#friends ) ) {
        die "The friends list is not increasing\n";
    }

    # Return the order of the friends we want
    my %friends_hash = ();
    @friends_hash{@friends} = ();
    my @result = grep { exists $friends_hash{$_} } @order;
    say "(", join( ", ", @result ), ")";
}

main(@ARGV);
