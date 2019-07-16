#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use constant SHARE_FACT => 0.01;

my $rest_of_the_pie = 1;
my ($max_guest, $max_sh) = (1, 0);
for my $guest_nr (1..100) {
    my $share = $rest_of_the_pie * $guest_nr * SHARE_FACT;
    ($max_guest, $max_sh) = ($guest_nr, $share) if $share > $max_sh;
    $rest_of_the_pie -= $share;
}
say "Lucky guest: $max_guest \tLargest share: $max_sh";
