#! /usr/bin/raku

use Test;

plan 2;

is-deeply(busroute([[12, 11, 41], [15, 5, 35]]), [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], 'example 1');
is-deeply(busroute([[12, 3, 41], [15, 9, 35], [30, 5, 25]]), [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59], 'example 2');

sub busroute(@a) {
    my @routes;
    for @a -> @rt {
        my %ri;
        my ($interval, $offset, $duration) = @rt;
        my $start = $offset;
        while ($start <= 60 + $offset) {
            %ri{$start} = $start + $duration;
            $start += $interval;
        }
        @routes.push(%ri);
    }
    my @out;
    for 0 .. 59 -> $t {
        my %best = SetHash.new;
        my $at = -1;
        my %nxt = SetHash.new;
        my $ndt = -1;
        for @routes.kv -> $i, %r {
            my $nb = %r.keys.grep({$_ >= $t}).min({ 0 + $_});
            my $nt = %r{$nb};
            if ($at == -1 || $nt < $at) {
                %best = SetHash.new;
                $at = $nt;
            }
            if ($nt <= $at) {
                %best{$i}++;
            }
            if ($ndt == -1 || $nb < $ndt) {
                %nxt = SetHash.new;
                $ndt = $nb;
            }
            if ($nb <= $ndt) {
                %nxt{$i}++
            }
        }
        if ((%best (&) %nxt).elems == 0) {
            @out.push($t);
        }
    }
    return @out;
}
