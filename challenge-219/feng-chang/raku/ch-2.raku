#!/bin/env raku

unit sub MAIN(Str:D $input);

use MONKEY-SEE-NO-EVAL;

my (@costs, @days);
EVAL $input;

my $expenditure = Inf;
my @Q = [@days.clone, 0], ;

while @Q {
    state @offsets = 1, 7, 30;
    my @Q_;

    for @Q -> (@days, $exp) {
        next if $exp > $expenditure;

        if +@days == 0 {
            $expenditure = min($exp, $expenditure);
            next;
        }

        for ^3 -> $j {
            my @days_ = @days.clone;

            my $last_day = @days_[0] + @offsets[$j];
            my $cnt = 0;
            while +@days_ && @days_[0] < $last_day {
                @days_.shift;
                ++$cnt;
            }
            next if $cnt < @costs[$j] / @costs[0];

            @Q_.push([@days_, $exp + @costs[$j]]);
        }
    }

    @Q = @Q_;
}

put $expenditure;
