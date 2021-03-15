#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

my $in = "in.txt";

is capture("perl perl/ch-1.pl 100   4 50  3  2"),   "(2, 3, 4)\n";
is capture("perl perl/ch-1.pl 100 101 50  3  2"),   "(2, 3)\n";
is capture("perl perl/ch-1.pl  20  30 10 40 50"),   "0\n";
is capture("perl perl/ch-1.pl  20  19  9 11 10"),   "(9, 10, 11)\n";

spew($in, <<END);
[ 0 0 0 1 0 0 ]
[ 1 1 1 0 0 0 ]
[ 0 0 1 0 0 1 ]
[ 1 1 1 1 1 0 ]
[ 1 1 1 1 1 0 ]
END
is capture("perl perl/ch-2.pl <$in"), <<END;
[ 1 1 1 1 1 ]
[ 1 1 1 1 1 ]
END

spew($in, <<END);
[ 1 0 1 0 1 0 ]
[ 0 1 0 1 0 1 ]
[ 1 0 1 0 1 0 ]
[ 0 1 0 1 0 1 ]
END
is capture("perl perl/ch-2.pl <$in"), <<END;
0
END

spew($in, <<END);
[ 0 0 0 1 1 1 ]
[ 1 1 1 1 1 1 ]
[ 0 0 1 0 0 1 ]
[ 0 0 1 1 1 1 ]
[ 0 0 1 1 1 1 ]
END
is capture("perl perl/ch-2.pl <$in"), <<END;
[ 1 1 1 1 ]
[ 1 1 1 1 ]
END

spew($in, <<END);
[ 1 ]
END
is capture("perl perl/ch-2.pl <$in"), <<END;
0
END

spew($in, <<END);
[ 1 1 ]
END
is capture("perl perl/ch-2.pl <$in"), <<END;
[ 1 1 ]
END

spew($in, <<END);
[ 1 1 ]
[ 1 0 ]
END
is capture("perl perl/ch-2.pl <$in"), <<END;
[ 1 1 ]
END

spew($in, <<END);
[ 1 1 ]
[ 1 0 ]
[ 1 0 ]
END
is capture("perl perl/ch-2.pl <$in"), <<END;
[ 1 ]
[ 1 ]
[ 1 ]
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
