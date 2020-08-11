#!/usr/bin/env perl
use strict;
use warnings;
use Time::HiRes qw/gettimeofday usleep/;
use Time::Piece;
use Text::Banner;
use Term::ANSIScreen 'cls';

my $banner = Text::Banner->new;
$banner->size (10);
while (1) {
    my ($s, $us) = gettimeofday();
    $banner->set (localtime ($s % 86400)->hms);
    cls;
    print $banner->get;
    usleep (1e6 - $us);
}
