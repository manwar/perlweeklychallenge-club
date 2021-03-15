#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

my $in = "in.txt";

is capture("perl/ch-1.pl 1"),           "1\n";
is capture("perl/ch-1.pl 0"),           "0\n";
is capture("perl/ch-1.pl -1"),          "-1\n";
is capture("perl/ch-1.pl 1234"),        "4321\n";
is capture("perl/ch-1.pl -1234"),       "-4321\n";
is capture("perl/ch-1.pl -2147483649"), "0\n";
is capture("perl/ch-1.pl -2147483648"), "-8463847412\n";
is capture("perl/ch-1.pl  2147483647"), "7463847412\n";
is capture("perl/ch-1.pl  2147483648"), "0\n";

spew($in, <<END);
[ 0 1 0 1 ]
[ 0 0 1 0 ]
[ 1 1 0 1 ]
[ 1 0 0 1 ]
END
is capture("perl perl/ch-2.pl <$in"), "1\n";

spew($in, <<END);
[ 1 1 0 1 ]
[ 1 1 0 0 ]
[ 0 1 1 1 ]
[ 1 0 1 1 ]
END
is capture("perl perl/ch-2.pl <$in"), "4\n";

spew($in, <<END);
[ 0 1 0 1 ]
[ 1 0 1 0 ]
[ 0 1 0 0 ]
[ 1 0 0 1 ]
END
is capture("perl perl/ch-2.pl <$in"), "0\n";


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
