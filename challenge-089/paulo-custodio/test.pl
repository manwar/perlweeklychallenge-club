#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

# task 1

ok system("fbc basic/ch-1.bas") == 0;
for ([3,3], [4,7]) {
    my($in, $out) = @$_;
    is capture("basic/ch-1 $in"), " $out\n";
    is capture("perl perl/ch-1.pl $in"), "$out\n";
    is capture("gforth -e $in forth/ch-1.fs"), "$out\n";
}

# task 2

ok system("fbc basic/ch-2.bas") == 0;

is capture("perl perl/ch-2.pl"), <<END;
[ 2 9 4 ]
[ 7 5 3 ]
[ 6 1 8 ]
END

for ("basic/ch-2",
     "gforth forth/ch-2.fs") {
    is capture($_), <<END;
[ 2 7 6 ]
[ 9 5 1 ]
[ 4 3 8 ]
END
}

done_testing;

# capture output, normalize eol
sub capture {
    my($cmd) = @_;
    local $_ = `$cmd`;
    s/[ \t\r]*\n/\n/g;
    return $_;
}
