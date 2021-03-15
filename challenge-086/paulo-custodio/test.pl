#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

my $in = "in.txt";

is capture("perl perl/ch-1.pl 10 8 12 15 5       7"), "1\n";
is capture("perl perl/ch-1.pl 1 5 2 9 7          6"), "1\n";
is capture("perl perl/ch-1.pl 10 30 20 50 40    15"), "0\n";


spew($in, <<END);
[ _ _ _ 2 6 _ 7 _ 1 ]
[ 6 8 _ _ 7 _ _ 9 _ ]
[ 1 9 _ _ _ 4 5 _ _ ]
[ 8 2 _ 1 _ _ _ 4 _ ]
[ _ _ 4 6 _ 2 9 _ _ ]
[ _ 5 _ _ _ 3 _ 2 8 ]
[ _ _ 9 3 _ _ _ 7 4 ]
[ _ 4 _ _ 5 _ _ 3 6 ]
[ 7 _ 3 _ 1 8 _ _ _ ]
END
is capture("perl perl/ch-2.pl <$in"), <<END;
[ 4 3 5 2 6 9 7 8 1 ]
[ 6 8 2 5 7 1 4 9 3 ]
[ 1 9 7 8 3 4 5 6 2 ]
[ 8 2 6 1 9 5 3 4 7 ]
[ 3 7 4 6 8 2 9 1 5 ]
[ 9 5 1 7 4 3 6 2 8 ]
[ 5 1 9 3 2 6 8 7 4 ]
[ 2 4 8 9 5 7 1 3 6 ]
[ 7 6 3 4 1 8 2 5 9 ]
END

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
