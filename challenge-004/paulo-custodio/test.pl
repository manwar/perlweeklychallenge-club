#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl 20"), <<END;
3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367893
END

# build list of words for testing
ok 0==system("aspell -d en dump master | aspell -l en expand > words.txt");

is capture("perl perl/ch-2.pl world"), <<END;
or
ow
owl
old
lo
low
lord
row
rd
rod
do
wold
world
word
END


done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
