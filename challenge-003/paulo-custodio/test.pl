#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl 20"), <<END;
1
2
3
4
5
6
8
9
10
12
15
16
18
20
24
25
27
30
32
36
END

is capture("perl perl/ch-2.pl 10"), <<END;
          1
         1 1
        1 2 1
       1 3 3 1
      1 4 6 4 1
     1 5 10 10 5 1
    1 6 15 20 15 6 1
   1 7 21 35 35 21 7 1
  1 8 28 56 70 56 28 8 1
 1 9 36 84 126 126 84 36 9 1
END


done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
