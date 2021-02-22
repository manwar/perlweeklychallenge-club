#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

# build list of words for testing
ok 0==system("aspell -d en dump master | aspell -l en expand > words.txt");


is capture("perl perl/ch-1.pl 2019"), <<END;
0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5, 3, 0, 3, 2, 9, 0, 4, 9, 3, 6, 14, 0, 6, 3, 5, 15, 0, 5, 3, 5, 2, 17, 0, 6, 11, 0, 3, 8, 0, 3, 3, 1, 42, 0, 5, 15, 20, 0, 4, 32, 0, 3, 11, 18, 0, 4, 7, 0, 3, 7, 3, 2, 31, 0, 6, 31, 3, 6, 3, 2, 8, 33, 0, 9, 56, 0, 3, 8, 7, 19, 0, 5, 37, 0, 3, 8, 8, 1
END

is capture("perl perl/ch-2.pl"), <<END;
armorial = ARKANSAS + MISSOURI + RHODE ISLAND + ALABAMA
inguinal = INDIANA + GUAM + INDIANA + ALABAMA
calamine = CALIFORNIA + LOUISIANA + MICHIGAN + NEBRASKA
coalmine = COLORADO + ALABAMA + MICHIGAN + NEBRASKA
calamari = CALIFORNIA + LOUISIANA + MASSACHUSETTS + RHODE ISLAND
complain = COLORADO + NORTHERN MARIANA ISLANDS + LOUISIANA + INDIANA
Campinas = CALIFORNIA + NORTHERN MARIANA ISLANDS + INDIANA + AMERICAN SAMOA
Concorde = COLORADO + NORTH CAROLINA + OREGON + DELAWARE
Ganymede = GEORGIA + NEW YORK + MAINE + DELAWARE
cascaras = CALIFORNIA + SOUTH CAROLINA + ARKANSAS + AMERICAN SAMOA
landmine = LOUISIANA + NORTH DAKOTA + MICHIGAN + NEBRASKA
melamine = MAINE + LOUISIANA + MICHIGAN + NEBRASKA
moorland = MISSOURI + OREGON + LOUISIANA + NORTH DAKOTA
malarial = MASSACHUSETTS + LOUISIANA + RHODE ISLAND + ALABAMA
memorial = MAINE + MISSOURI + RHODE ISLAND + ALABAMA
mainland = MASSACHUSETTS + INDIANA + LOUISIANA + NORTH DAKOTA
mandalas = MASSACHUSETTS + NORTH DAKOTA + ALABAMA + AMERICAN SAMOA
Mandarin = MASSACHUSETTS + NORTH DAKOTA + ARKANSAS + INDIANA
mandarin = MASSACHUSETTS + NORTH DAKOTA + ARKANSAS + INDIANA
mescalin = MAINE + SOUTH CAROLINA + ALABAMA + INDIANA
mascaras = MASSACHUSETTS + SOUTH CAROLINA + ARKANSAS + AMERICAN SAMOA
Victoria = VIRGIN ISLANDS + CONNECTICUT + OREGON + IOWA
Vineland = VIRGIN ISLANDS + NEBRASKA + LOUISIANA + NORTH DAKOTA
END

unlink "words.txt";
done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}
