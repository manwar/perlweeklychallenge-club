#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

# task 1

is `perl perl/ch-1.pl 3`, "3\n";
is `perl perl/ch-1.pl 4`, "7\n";

is `gforth -e 3 forth/ch-1.fs`, "3 \n";
is `gforth -e 4 forth/ch-1.fs`, "7 \n";

# task 2

is `perl perl/ch-2.pl`, <<END;
[ 2 9 4 ]
[ 7 5 3 ]
[ 6 1 8 ]
END

is `gforth forth/ch-2.fs`, <<END;
[ 2 7 6 ]
[ 9 5 1 ]
[ 4 3 8 ]
END

done_testing;
