#! /usr/bin/raku

use Test;

plan 3;

is-deeply(shortestroute([[1, 2, 6], [5, 6, 7]], 1, 7), [1, 2, 6, 7], 'example 1');
is-deeply(shortestroute([[1, 2, 3], [4, 5, 6]], 2, 5), [], 'example 2');
is-deeply(shortestroute([[1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]], 1, 7), [1, 2, 3, 8, 7], 'example 3');

sub shortestroute(@r0, $origin, $destination) {
    my %r;
    for @r0 -> @rt {
        for @rt.rotor(2 => -1) -> @rp {
            %r{@rp[0]} ||= SetHash.new;
            %r{@rp[0]}{@rp[1]}++;
            %r{@rp[1]} ||= SetHash.new;
            %r{@rp[1]}{@rp[0]}++;
        }
    }
    my @out;
    my @stack = ([$origin,],);
    while (@stack.elems > 0) {
        my @s = @stack.shift.flat;
        my $l = @s[*-1];
        if ($l == $destination) {
            @out = @s;
            last;
        } else {
            my %s1 = Set.new(@s);
            for %r{$l}.keys -> $pd {
                unless (%s1{$pd}:exists) {
                    my @q = @s.clone;
                    @q.push($pd);
                    @stack.push(@q);
                }
            }
        }
    }
    return @out;
}
