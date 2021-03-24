#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("gawk -f ./awk/ch-1.awk 5 248832"), "12\n";
is capture("gawk -f ./awk/ch-1.awk 5 34    "),  "2.0244\n";


is capture("gawk -f ./awk/ch-2.awk Katie"), <<END;
Katie, Katie, bo-batie,
Bonana-fanna fo-fatie
Fee fi mo-matie
Katie!
END

is capture("gawk -f ./awk/ch-2.awk Billy"), <<END;
Billy, Billy, bo-illy,
Bonana-fanna fo-filly
Fee fi mo-milly
Billy!
END

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    return $out =~ s/\r//gr;
}
