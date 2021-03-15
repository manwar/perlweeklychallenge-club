#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl 6"), <<END;
1 + 2 + 3 = 6
1 + 5 = 6
END

is capture("perl perl/ch-1.pl 9"), <<END;
1 + 3 + 5 = 9
1 + 8 = 9
END

is capture("perl perl/ch-1.pl 100"), <<END;
1 + 13 + 2 + 21 + 3 + 5 + 55 = 100
1 + 13 + 2 + 21 + 55 + 8 = 100
1 + 2 + 3 + 34 + 5 + 55 = 100
1 + 2 + 3 + 5 + 89 = 100
1 + 2 + 34 + 55 + 8 = 100
1 + 2 + 8 + 89 = 100
13 + 21 + 3 + 55 + 8 = 100
3 + 34 + 55 + 8 = 100
3 + 8 + 89 = 100
END

is capture("perl perl/ch-2.pl ".
                "OOX ".
                "XOO ".
                "XOO "), "1\n";
is capture("perl perl/ch-2.pl ".
                "OOXO ".
                "XOOO ".
                "XOOX ".
                "OXOO "), "2\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
