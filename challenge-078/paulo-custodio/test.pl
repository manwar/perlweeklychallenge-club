#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl 9 10 7 5 6 1"),   "(10, 7, 6, 1)\n";
is capture("perl perl/ch-1.pl 3  4 5"),         "(5)\n";
is capture("perl perl/ch-1.pl "),               "(0)\n";
is capture("perl perl/ch-1.pl 0 0 0 0 0"),      "(0)\n";

is capture("perl perl/ch-2.pl '10 20 30 40 50' '3 4'"), <<END;
[40 50 10 20 30]
[50 10 20 30 40]
END

is capture("perl perl/ch-2.pl '7 4 2 6 3' '1 3 4'"), <<END;
[4 2 6 3 7]
[6 3 7 4 2]
[3 7 4 2 6]
END

is capture("perl perl/ch-2.pl '7 4 2 6 3' '0 1 2 3 4'"), <<END;
[7 4 2 6 3]
[4 2 6 3 7]
[2 6 3 7 4]
[6 3 7 4 2]
[3 7 4 2 6]
END

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
