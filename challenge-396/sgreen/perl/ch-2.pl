#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main (@ints) {
    my $words = ();
    my %dir   = ( -1 => "u", 0 => "s", 1 => "d" );
    my $directions =
      join( "", map { $dir{ $ints[ $_ - 1 ] <=> $ints[$_] } } ( 1 .. $#ints ) );

    if ( $directions =~ /^u+d+u+$/ ) {
        say "true";
    }
    else {
        say "false";
    }
}

main(@ARGV);
