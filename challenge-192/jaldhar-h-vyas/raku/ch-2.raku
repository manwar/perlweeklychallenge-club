#!/usr/bin/raku

sub MAIN(*@n) {
    my $moves;

    if @n.sum !%% @n.elems {
        $moves = -1;
    } else {

        my $balance = @n.sum div @n.elems;
        my @m = @n;

        until @m.all == $balance {
            for 0 .. @m.end -> $i {
                if @m[$i] == 0 {
                    next;
                }
                elsif @m[$i] < $balance {
                    if $i > 0 && @m[$i - 1] > @m[$i] {
                        @m[$i - 1]--;
                        @m[$i]++;
                        $moves++;
                    }

                    if $i < @m.end && @m[$i + 1] > @m[$i] {
                        @m[$i + 1]--;
                        @m[$i]++;
                        $moves++;
                    }
                }
                elsif @m[$i] > $balance {
                    if $i > 0 && @m[$i - 1] < @m[$i] {
                        @m[$i - 1]++;
                        @m[$i]--;
                        $moves++;
                    }

                    if $i < @m.end && @m[$i + 1] < @m[$i] {
                        @m[$i + 1]++;
                        @m[$i]--;
                        $moves++;
                    }
                }
            }
        }
    }

    say $moves;
}