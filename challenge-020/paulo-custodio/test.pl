#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("perl perl/ch-1.pl ABBCDEEF"), <<END;
"A", "BB", "C", "D", "EE", "F".
END

is capture("perl perl/ch-2.pl"), "(220,284)\n";

done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}
