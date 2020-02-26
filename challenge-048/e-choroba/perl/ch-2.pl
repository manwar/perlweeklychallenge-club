#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Time::Piece;

my $date = 'Time::Piece'->strptime('2000-01-01', '%Y-%m-%d');
while ($date->year < 3000) {
    my $formatted = $date->strftime('%m%d%Y');
    say $date->strftime('%B %-d, %Y') if $formatted eq reverse $formatted;
    $date += Time::Seconds::ONE_DAY;

    # Optimisation.
    $date = 'Time::Piece'->strptime(($date->year + 1) . '-01-01', '%Y-%m-%d')
        if reverse(int($date->year / 100)) > 31
        || reverse($date->year % 100) > 12;
}
