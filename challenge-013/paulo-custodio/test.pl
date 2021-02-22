#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("perl perl/ch-1.pl 2019"), <<END;
2019/01/25
2019/02/22
2019/03/29
2019/04/26
2019/05/31
2019/06/28
2019/07/26
2019/08/30
2019/09/27
2019/10/25
2019/11/29
2019/12/27
END

is capture("perl perl/ch-1.pl 2021"), <<END;
2021/01/29
2021/02/26
2021/03/26
2021/04/30
2021/05/28
2021/06/25
2021/07/30
2021/08/27
2021/09/24
2021/10/29
2021/11/26
2021/12/31
END


is capture("perl perl/ch-2.pl 3"), <<END;
F: 1, 1, 2, ...
M: 0, 0, 1, ...
END

is capture("perl perl/ch-2.pl 21"), <<END;
F: 1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 13, ...
M: 0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12, 12, ...
END

done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}
