#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

# build list of words for testing
ok 0==system("aspell -d en dump master | aspell -l en expand > words.txt");

is capture("perl perl/ch-1.pl binary"), <<END;
binary
brainy
END

is capture("perl perl/ch-1.pl live"), <<END;
evil
levi
live
veil
vile
END

is capture("perl perl/ch-1.pl casper"), <<END;
capers
crapes
parsec
pacers
recaps
scrape
spacer
casper
END


is capture("perl perl/ch-2.pl"), <<END;
Maximum of 8 anagrams
aceprs
aels
aelst
aerst
egor
END

unlink "words.txt";
done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
