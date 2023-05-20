#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub max_number(@list) {
    return join "",
        sort { (0 == index $a, $b) ? -compare($a, $b)
             : (0 == index $b, $a) ? compare($b, $a)
                                   : $b cmp $a
        } @list
}

sub compare($x, $y) {
    my ($lx, $ly) = map length, $x, $y;
    return $x cmp $y if $lx == $ly;

    my ($posx, $posy) = ($ly, 0);
    my ($xx, $yy) = ($x, $x);
    my $over = 0;
    my $count = 0;
    while ($over < 2
           && substr($xx, $posx, 1) eq substr($yy, $posy, 1)
    ) {
        ++$count;
        ++$over, $yy = $x, $posy = 0 if ++$posy >= length $yy;
        ++$over, $xx = $y, $posx = 0 if ++$posx >= length $xx;
    }

    return substr($xx, $posx, 1) cmp substr($yy, $posy, 1)
}

use Test::More tests => 5 + 3 * 6 + 3 + 1;

is max_number(1, 23), 231, 'Example 1';
is max_number(10, 3, 2), 3210, 'Example 2';
is max_number(31, 2, 4, 10), 431210, 'Example 3';
is max_number(5, 11, 4, 1, 2), 542111, 'Example 4';
is max_number(1, 10), 110, 'Example 5';

is max_number(53, 531, 2), 535312, 't 53 531';
is max_number(531, 53, 2), 535312, 't 531 53';
is max_number(53, 535, 2), 535532, 't 53 535';
is max_number(535, 53, 2), 535532, 't 535 53';
is max_number(53, 536, 2), 536532, 't 53 536';
is max_number(536, 53, 2), 536532, 't 536 53';

is max_number(4567, 45673), 456745673, 't 4567+3';
is max_number(4567, 45674), 456745674, 't 4567+4';
is max_number(4567, 45675), 456754567, 't 4567+5';
is max_number(45673, 4567), 456745673, 't 4567+3 rev';
is max_number(45674, 4567), 456745674, 't 4567+4 rev';
is max_number(45675, 4567), 456754567, 't 4567+5 rev';

is max_number(445671, 44567), 44567445671, 'recursion <';
is max_number(445674, 44567), 44567445674, 'recursion =';
is max_number(445675, 44567), 44567544567, 'recursion >';
is max_number(44567, 445671), 44567445671, 'recursion < rev';
is max_number(44567, 445674), 44567445674, 'recursion = rev';
is max_number(44567, 445675), 44567544567, 'recursion > rev';

is max_number(23, 23, 231), 2323231, 'repeated <';
is max_number(23, 23, 232), 2323232, 'repeated =';
is max_number(23, 23, 233), 2332323, 'repeated >';

is max_number(4, 447, 3, 331, 4340, 43), '44744343403331', 'bug';
