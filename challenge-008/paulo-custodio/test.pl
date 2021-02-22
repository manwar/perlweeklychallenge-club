#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("perl perl/ch-1.pl 5"), <<END;
6
28
496
8128
33550336
END

is capture("perl perl/ch-2.pl 'This' 'is' 'a test of the' 'center function'"), <<END;
     This
      is
 a test of the
center function
END

done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}
