#!/bin/env raku

unit sub MAIN(*@N);

my %G = @N.join(',') => 0;
my $score = 0;

while True {
    my %G_;

    for %G.keys -> $k {
        my @nums = $k.comb(/\d+/)».Int;
        my $total = %G{$k};

        my ($i, $j) = 0, 0;
        while $j + 1 ≤ +@nums {
            ++$j while @nums[$j+1].defined and @nums[$j+1] == @nums[$i];
            my @nums_ = @nums;
            my $score_ = $total + ($j - $i + 1)²;

            @nums_.splice($i, $j - $i + 1);
            my $k_ = @nums_.join(',');

            $score_ = max($score_, %G_{$k_} // 0);
            %G_{$k_} = $score_;

            $score = $score_ if $score_ > $score;

            $i = ++$j;
        }
    }

    last unless +%G_;
    %G = %G_;
}

put $score;
