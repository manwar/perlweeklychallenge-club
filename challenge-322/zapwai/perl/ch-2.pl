use v5.38;

# When a rank is matched we shift the remaining ranks down
sub shift_ranks($r, $i) {
    for my $j ($i .. $#$r) {
        $$r[$j]--;
    }
}

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my @o = sort {$a <=> $b} @ints;
    my @r = (1 .. @o);
    for my $i (0 .. $#o - 1) {
        if ($o[$i+1] == $o[$i]) {
            $r[$i+1] = $r[$i];
            unless ($i+2 > $#o) {
                if ($r[$i+2] - $r[$i+1] > 1) {
                    shift_ranks(\@r, $i + 2);
                }
            }
        }
    }
    my @out;
    for my $int (@ints) {
        for my $i (0 .. $#o) {
            if ($o[$i] == $int) {
                push @out, $r[$i];
                last;
            }
        }
    }
    say "Output: @out";
}
my @ints = (55, 22, 44, 33);
proc(@ints);
@ints = (10, 10, 10);
proc(@ints);
@ints = (5, 1, 1, 4, 3);
proc(@ints);
