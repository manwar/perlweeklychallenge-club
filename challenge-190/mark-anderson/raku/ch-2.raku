#!/usr/bin/env raku
use Test;

is-deeply decoded-list(11),      < AA K >;
is-deeply decoded-list(1115),    < AAAE AAO AKE KAE KO >;
is-deeply decoded-list(127),     < ABG LG >;
is-deeply decoded-list(1002005), < ABE JBE JTE >;

sub decoded-list($n is copy)
{
    $n ~~ s:g/0+/0/; # Ignoring leading zeros to make things easy.

    ones-and-twos($n.chars).map({ $n.comb.rotor($_)>>.join>>.Int })
                           .grep({ all($_) ~~ 1..26 })
                           .deepmap({ chr($_ + 64) })
                           .map({ .join });
}

sub ones-and-twos($n)
{
    my $start = ((0,0,1) xx *).flat.head($n).join.parse-base(2);
    my $stop  = ((0,1,1) xx *).flat.head($n).join.parse-base(2);

    sort map 
    {
        my $b = .fmt('%0' ~ $n ~ 'b');
        next if $b ~~ /000|111/;
        gather $b ~~ m:g/(.)$0? <?{ take $/.pos - $/.from }>/
    }, $start..$stop
}
