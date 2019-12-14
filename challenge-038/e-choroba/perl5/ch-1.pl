#!/usr/bin/perl
use warnings;
use strict;

use Time::Piece;

sub validate {
    my ($number) = @_;
    die 'Invalid length' unless length $number == 7;

    my $date = {  1 => 20, 2 => 19 }->{ substr $number, 0, 1 }
        or die 'Invalid year';

    $date .= substr $number, 1;
    my $tp = eval { 'Time::Piece'->strptime($date, '%Y%m%d') };
    die 'Invalid date' unless $tp && $tp->mon == substr $number, 3, 2;

    return $tp->ymd
}

use Test::More;
use Test::Exception;

throws_ok { validate('123456') }   qr/Invalid length/, 'too short';
throws_ok { validate('12345678') } qr/Invalid length/, 'too long';

throws_ok { validate('3234567') } qr/Invalid year/, 'year';

throws_ok { validate('2xxxxxx') } qr/Invalid date/, 'xxx';
throws_ok { validate('1031301') } qr/Invalid date/, 'Undecember 1 2003';
throws_ok { validate('1030229') } qr/Invalid date/, 'Feb 29 2003';
throws_ok { validate('1040230') } qr/Invalid date/, 'Feb 30 2004';

is validate('1040229'), '2004-02-29', 'Feb 29 2004';
is validate('2801231'), '1980-12-31', 'Dec 31 1980';
is validate('2230120'), '1923-01-20', 'the example';


done_testing();
