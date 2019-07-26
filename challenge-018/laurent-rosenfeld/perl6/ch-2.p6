use v6;
sub new-queue {
    my @queue;  # an AoA
    sub is_empty {
        @queue.elems == 0;
    }
    sub insert_with_prio ($item, Int $prio) {
        my $index = first {@queue[$_][0] == $prio}, @queue.keys;
        if (defined $index) {
            push @queue[$index][1], $item;
        } else {
            push @queue, [$prio, [$item]];
            my $idx = @queue.end;
            add-to-queue($idx);
        }
    }
    sub pull_highest_prio {
        return Nil if is-empty;
        my $result = shift @queue[0][1];
        take-from-heap if @queue[0][1].elems == 0;
        return $result;
    }
    sub add-to-queue ($index is rw) {
        my $index-val = @queue[$index];
        while ($index) {
            my $parent-idx = Int( ($index - 1) /2);
            my $parent-val = @queue[$parent-idx];
            last if $parent-val[0] > $index-val[0];
            @queue[$index] = $parent-val;
            $index = $parent-idx;
        }
        @queue[$index] = $index-val;
    }
    sub take-from-heap {
        my $index = 0;
        loop {
            my $left-index = 2 * $index + 1;
                # right-index is $left-index + 1
            unless (defined @queue[$left-index] or
                defined @queue[$left-index + 1]) {
                    @queue.splice($index, 1);
                    last;
            }
            unless defined @queue[$left-index + 1] {
                @queue[$index] = @queue[$left-index]:delete;
                last;
            }
            unless defined @queue[$left-index] {
                @queue[$index] = @queue[$left-index + 1]:delete;
                last;
            }
            # both children are defined if we get here
            my $next-index = ($left-index,
                $left-index + 1).max({@queue[$_][0]});
            @queue[$index] = @queue[$next-index];
            $index = $next-index;
        }
    }

    return &is_empty, &insert_with_prio, &pull_highest_prio;
}
my (&is-empty, &insert, &pull-prio) = new-queue;
# Testing the above code: 20 insertions and then trying 30 deletions
for 1..20 -> $num {
    insert($num,
        $num %% 10 ?? 10 !!
        $num %% 5  ?? 5  !!
        $num %% 3  ?? 3  !!
        $num %% 2  ?? 2  !!
        1);
}
for 1..30 -> $num {
    last if is-empty;
    say pull-prio;
}
say "Empty queue" if is-empty();
