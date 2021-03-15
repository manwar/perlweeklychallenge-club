#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("perl perl/ch-1.pl 1"), "1\n";
is capture("perl perl/ch-1.pl 2"), "16\n";
is capture("perl perl/ch-1.pl 3"), "169\n";
is capture("perl perl/ch-1.pl 4"), "1024\n";
is capture("perl perl/ch-1.pl 5"), "12769\n";


is capture("perl perl/ch-2.pl 2 3 1 4 2 2 1 0"), <<END;
Data:             2, 3, 1, 4, 2, 2, 1, 0
Standard ranking: 3, 2, 6, 1, 3, 3, 6, 8
Modified ranking: 5, 2, 7, 1, 5, 5, 7, 8
Dense ranking:    3, 2, 4, 1, 3, 3, 4, 5
END


done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}
