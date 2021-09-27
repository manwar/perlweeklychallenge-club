#!/usr/bin/env raku

say mirror-dates('1967/02/14');

sub mirror-dates($date)
{
    my $t = Date.today;
    my $d = Date.new(|$date.split("/"));

    my $days = $t - $d;

    ($d.earlier(:$days).yyyy-mm-dd('/'),
     $t.later(:$days).yyyy-mm-dd('/'));
}
