
sub play-jump-game (@N) {
    my Bool @reachable = @N.map({ False });
    @reachable[ @reachable.end ] = True;

    for @N.end-1 ... 0 -> $i {
        my $maxjump = @N[$i];
        @reachable[$i] = any( @reachable[$i+1 .. min($i+$maxjump, @reachable.end)]).Bool;
    }

    say '@N = ' ~ @N.raku;
    say @reachable[0] ?? 1 !! 0;
}

play-jump-game([1, 2, 1, 2]);
play-jump-game([2, 1, 0, 0, 2]);
play-jump-game([2, 2, 4, 1, 2, 0, 1, 1]);
