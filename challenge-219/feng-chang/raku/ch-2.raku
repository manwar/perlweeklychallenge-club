#!/bin/env raku

unit sub MAIN(Str:D $input);

use MONKEY-SEE-NO-EVAL;

my (@costs, @days);
EVAL $input;

my $expenditure = Inf;
my @Q = [@days.clone, 0], ;
while @Q {
    my @Q_;

    for @Q -> (@days, $exp) {
        if +@days == 0 {
            $expenditure = min($exp, $expenditure);
            next;
        }

        for ^3 -> $j {
            my @days_ = @days.clone;
            my $exp_  = $exp;

            given $j {
                when 0 {
                    @days_.shift;
                    $exp_ += @costs[0];
                }
                when 1 {
                    my $last_day = @days_[0] + 7;
                    my $cnt = 0;

                    while +@days_ && @days_[0] < $last_day {
                        @days_.shift;
                        ++$cnt;
                    }
                    next if $cnt ≤ @costs[1] / @costs[0];

                    $exp_ += @costs[1];
                }
                when 2 {
                    my $last_day = @days_[0] + 30;
                    my $cnt = 0;

                    while +@days_ && @days_[0] < $last_day {
                        @days_.shift;
                        ++$cnt;
                    }
                    next if $cnt ≤ @costs[2] / @costs[0];

                    $exp_ += @costs[2];
                }
            }

            @Q_.push([@days_.clone, $exp_]);
        }
    }

    @Q = @Q_;
}

put $expenditure;
