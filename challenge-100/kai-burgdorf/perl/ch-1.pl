#!/usr/bin/perl

use strict;
use warnings;

my $input = $ARGV[0];    #8:30 pm

die "usage: ch-1.pl [timestring]" if ( !$input );

my ( $hours, $minutes ) = split( ":", $input, 2 );

my $result;

if ( $minutes =~ /.*am*|.*pm*/ ) {
    my $is_am = ( $minutes =~ /.*am/ ) ? 1 : 0;
    $minutes =~ s/am|pm//;    #optionales space in regex
    $result = ($is_am) ? "$hours:$minutes\n" : "" . ( $hours + 12 ) . ":$minutes\n";
}
else {
    my $is_early = ( $hours < 12 || $hours == 24 ) ? 1 : 0;
    if ( $hours == 24 || $hours == 0 ) {
        $hours = 12;
    }
    elsif ( !$is_early && $hours > 12 ) {
        $hours -= 12;
    }
    $result = "$hours:$minutes";
    $result .= ($is_early) ? "am\n" : "pm\n";
}

print "$result";
