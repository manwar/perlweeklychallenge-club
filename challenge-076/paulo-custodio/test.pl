#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl  2"), "2 = 2\n";
is capture("perl perl/ch-1.pl  3"), "3 = 3\n";
is capture("perl perl/ch-1.pl  4"), "2 + 2 = 4\n";
is capture("perl perl/ch-1.pl  5"), "5 = 5\n";
is capture("perl perl/ch-1.pl  6"), "3 + 3 = 6\n";
is capture("perl perl/ch-1.pl  7"), "7 = 7\n";
is capture("perl perl/ch-1.pl  8"), "3 + 5 = 8\n";
is capture("perl perl/ch-1.pl  9"), "2 + 7 = 9\n";
is capture("perl perl/ch-1.pl 10"), "3 + 7 = 10\n";
is capture("perl perl/ch-1.pl 11"), "11 = 11\n";
is capture("perl perl/ch-1.pl 12"), "5 + 7 = 12\n";
is capture("perl perl/ch-1.pl 13"), "13 = 13\n";


# build list of words for testing
ok 0==system("aspell -d en dump master | aspell -l en expand > words.txt");

is capture("perl perl/ch-2.pl grid.txt words.txt"), <<END;
aimed, align, antes, arose, ashed, blunt, blunts, broad, buries, clove, cloven, constitution, constitutions, croon, depart, departed, enter, filch, garlic, goats, grieve, grieves, hazard, liens, malign, malignant, malls, midst, ought, ovary, parted, pudgiest, quash, quashed, raped, ruses, shrine, shrines, social, socializing, spasm, spasmodic, succor, succors, theorem, theorems, virus, viruses, wigged
END

unlink "words.txt";
done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
