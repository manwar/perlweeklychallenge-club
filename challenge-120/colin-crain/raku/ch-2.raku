#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $time = "12:55" );
say $time;

unless $time ~~ /^ (\d?\d) \: (\d\d) $/ { 
    die "usage:\n    time input in the form hh:mm" 
}

my $h-ang = ( $0 % 12 ) * 30 + $1 * 0.5;
my $m-ang = $1 * 6;
my $ang   = ( $h-ang - $m-ang ).abs;
$ang = 360 - $ang if $ang > 180;
say $ang;





