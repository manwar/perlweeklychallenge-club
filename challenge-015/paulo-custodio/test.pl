#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl"), <<END;
Strong Prime: 11, 17, 29, 37, 41, 59, 67, 71, 79, 97
Weak Prime:   3, 7, 13, 19, 23, 31, 43, 47, 61, 73
END

is capture("perl perl/ch-1.pl 47"), <<END;
Strong Prime: 11, 17, 29, 37, 41, 59, 67, 71, 79, 97, 101, 107, 127, 137, 149, 163, 179, 191, 197, 223, 227, 239, 251, 269, 277, 281, 307, 311, 331, 347, 367, 379, 397, 419, 431, 439, 457, 461, 479, 487, 499, 521, 541, 557, 569, 587, 599
Weak Prime:   3, 7, 13, 19, 23, 31, 43, 47, 61, 73, 83, 89, 103, 109, 113, 131, 139, 151, 167, 181, 193, 199, 229, 233, 241, 271, 283, 293, 313, 317, 337, 349, 353, 359, 383, 389, 401, 409, 421, 433, 443, 449, 463, 467, 491, 503, 509
END


is capture("perl perl/ch-2.pl encode LEMON ATTACKATDAWN"), "LXFOPVEFRNHR\n";
is capture("perl perl/ch-2.pl decode LEMON LXFOPVEFRNHR"), "ATTACKATDAWN\n";


done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
