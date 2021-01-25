#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl"), <<END;
machamp petilil landorus scrafty yamask kricketune emboar registeel loudred darmanitan nosepass simisear relicanth heatmor rufflet trapinch haxorus seaking girafarig gabite exeggcute emolga audino
END

my($text, $encoded) = qw( WELLDONEISBETTERTHANWELLSAID
                          OAHQHCNYNXTSZJRRHJBYHQKSOUJY );
is capture("perl perl/ch-2.pl encode $text"), "$encoded\n";
is capture("perl perl/ch-2.pl decode $encoded"), "$text\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
