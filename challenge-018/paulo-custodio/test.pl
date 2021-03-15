#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl ABABC BABCA ABCBA"), <<END;
("ABC")
END

is capture("perl perl/ch-1.pl ABABCBA BABCACBA ABCBCBA"), <<END;
("ABC", "CBA")
END

ok 0==system("perl perl/ch-2.pl");

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
