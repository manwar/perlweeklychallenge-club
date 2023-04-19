#!/usr/bin/perl

use v5.16;
use warnings;
use DateTime::Format::Strptime;

my $dt = DateTime::Format::Strptime->new(pattern => '%Y%m%d', strict => 1)
    ->parse_datetime(shift =~ s/^([12])/20 - ($1 > 1)/er);
$dt && say DateTime::Format::Strptime->new(pattern => '%Y-%m-%d')
    ->format_datetime($dt);

