
sub play-jump-game (@N) {
    my Bool @reachable = @N.map({ False });

    # [1]: $reachable[$i] = solution of the sub-problem: $i .. @N.end
    @reachable[ @reachable.end ] = True;

    # [2]: Solve the lightly bigger sub-problem each time
    for @N.end-1 ... 0 -> $i {
        my $maxjump = @N[$i];

        # [3]: Take 1 jump, see if I land on a pad that's known to reachable to the end
        @reachable[$i] = any( @reachable[$i+1 .. min($i+$maxjump, @reachable.end)]).Bool;
    }

    say '@N = ' ~ @N.raku;
    say @reachable[0] ?? 1 !! 0;
}

play-jump-game([1, 2, 1, 2]);
play-jump-game([2, 1, 0, 0, 2]);
play-jump-game([2, 2, 4, 1, 2, 0, 1, 1]);
