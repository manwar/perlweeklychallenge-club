#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl 0 0"), "1\n";
is capture("perl perl/ch-1.pl 0 1"), "2\n";
is capture("perl perl/ch-1.pl 0 2"), "3\n";
is capture("perl perl/ch-1.pl 0 3"), "4\n";
is capture("perl perl/ch-1.pl 0 4"), "5\n";

is capture("perl perl/ch-1.pl 1 0"), "2\n";
is capture("perl perl/ch-1.pl 1 1"), "3\n";
is capture("perl perl/ch-1.pl 1 2"), "4\n";
is capture("perl perl/ch-1.pl 1 3"), "5\n";
is capture("perl perl/ch-1.pl 1 4"), "6\n";

is capture("perl perl/ch-1.pl 2 0"), "3\n";
is capture("perl perl/ch-1.pl 2 1"), "5\n";
is capture("perl perl/ch-1.pl 2 2"), "7\n";
is capture("perl perl/ch-1.pl 2 3"), "9\n";
is capture("perl perl/ch-1.pl 2 4"), "11\n";

is capture("perl perl/ch-1.pl 3 0"), "5\n";
is capture("perl perl/ch-1.pl 3 1"), "13\n";
is capture("perl perl/ch-1.pl 3 2"), "29\n";
is capture("perl perl/ch-1.pl 3 3"), "61\n";
is capture("perl perl/ch-1.pl 3 4"), "125\n";


is capture('perl perl/ch-2.pl jdbc://user:password@localhost:3306/pwc?profile=true#h1'), <<END;
scheme:   jdbc
userinfo: user:password
host:     localhost
port:     3306
path:     /pwc
query:    profile=true
fragment: h1
END

is capture('perl perl/ch-2.pl jdbc://localhost:3306/pwc?profile=true#h1'), <<END;
scheme:   jdbc
userinfo:
host:     localhost
port:     3306
path:     /pwc
query:    profile=true
fragment: h1
END

is capture('perl perl/ch-2.pl jdbc://localhost/pwc?profile=true#h1'), <<END;
scheme:   jdbc
userinfo:
host:     localhost
port:
path:     /pwc
query:    profile=true
fragment: h1
END

is capture('perl perl/ch-2.pl jdbc:/pwc?profile=true#h1'), <<END;
scheme:   jdbc
userinfo:
host:
port:
path:     /pwc
query:    profile=true
fragment: h1
END

is capture('perl perl/ch-2.pl jdbc:/pwc?profile=true'), <<END;
scheme:   jdbc
userinfo:
host:
port:
path:     /pwc
query:    profile=true
fragment:
END

is capture('perl perl/ch-2.pl jdbc:/pwc'), <<END;
scheme:   jdbc
userinfo:
host:
port:
path:     /pwc
query:
fragment:
END

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
