#! /usr/bin/raku

sub lsub(@wm, $t) {
    my $start = 0;
    my $state = 0;
    my @ll;
    for 0 .. @wm.end -> $n {
        if ($state == 0) {
            if (@wm[$n] eq $t) {
                $start = $n;
                $state = 1;
            }
        } else {
            if (@wm[$n] ne $t) {
                push @ll, $n - $start;
                $state = 0;
            }
        }
    }
    if ($state == 1) {
        push @ll, @wm.elems - $start;
    }
    max(@ll);
}

sub longestrepeatingcharacter($st, $k) {
    my @origin = $st.comb;
    my %targets = Set.new(@origin);
    my $longestsub = 0;
    for %targets.keys -> $t {
        my @queue;
        @queue.push({ wm => @origin, ct => 0});
        while (@queue.elems > 0) {
            my %wmct = @queue.shift;
            my @wm = %wmct{"wm"}.flat;
            my $ct = %wmct{"ct"};
            $longestsub = max($longestsub, lsub(@wm, $t));
            if ($ct < $k) {
                my $ctp = $ct + 1;
                for 0 .. @wm.end -> $n {
                    if (@wm[$n] ne $t) {
                        my @wmp = @wm.clone;
                        @wmp[$n] = $t;
                        @queue.push({wm => @wmp, ct => $ctp});
                    }
                }
            }
        }
    }
    $longestsub;
}

use Test;

plan 5;

is(longestrepeatingcharacter('AAAAA', 2), 5, 'example 1');
is(longestrepeatingcharacter('ABCDE', 4), 5, 'example 2');
is(longestrepeatingcharacter('AAABBBBAA', 1), 5, 'example 3');
is(longestrepeatingcharacter('ABACADA', 2), 5, 'example 4');
is(longestrepeatingcharacter('BAAABAAAA', 1), 8, 'example 5');
