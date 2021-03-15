#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

my $in = "in.txt";

is capture("perl perl/ch-1.pl 5 2 1 4 3"), "(24, 60, 120, 30, 40)\n";
is capture("perl perl/ch-1.pl 2 1 4 3  "), "(12, 24, 6, 8)\n";
is capture("perl perl/ch-1.pl 0 1 4 3  "), "(12, 0, 0, 0)\n";
is capture("perl perl/ch-1.pl 1 1 1 1  "), "(1, 1, 1, 1)\n";

spew($in, <<END);
[ 5 ]
END
is capture("perl perl/ch-2.pl <$in"), "[ 5 ]\n";

spew($in, <<END);
[ 1, 2, 3 ]
END
is capture("perl perl/ch-2.pl <$in"), "[ 1, 2, 3 ]\n";

spew($in, <<END);
[ 1, 2, 3 ]
[ 7, 8, 9 ]
END
is capture("perl perl/ch-2.pl <$in"), "[ 1, 2, 3, 9, 8, 7 ]\n";

spew($in, <<END);
[ 1 ]
[ 4 ]
[ 7 ]
END
is capture("perl perl/ch-2.pl <$in"), "[ 1, 4, 7 ]\n";

spew($in, <<END);
[ 1, 2, 3 ]
[ 4, 5, 6 ]
[ 7, 8, 9 ]
END
is capture("perl perl/ch-2.pl <$in"), "[ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]\n";

spew($in, <<END);
[  1,  2,  3,  4 ]
[  5,  6,  7,  8 ]
[  9, 10, 11, 12 ]
[ 13, 14, 15, 16 ]
END
is capture("perl perl/ch-2.pl <$in"),
    "[ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]\n";

unlink($in);
done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}

sub spew {
    my($file, $text) = @_;
    open(my $fh, ">", $file) or die "write $file: $!\n";
    print $fh $text;
}
