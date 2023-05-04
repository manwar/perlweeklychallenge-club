#!/bin/env raku

unit sub MAIN(*@N);

class Group {
    has Int  $.number;
    has UInt $.count;

    method score()        { $.count * $.count }
    method Str()          { "{$.number} {$.count}" }
    method eq(Group:D $g) { $.number == $g.number && $.count == $g.count }
}

@N = @N».Int.Array;

my @g;
my ($i, $j) = 0, 0;
while $j + 1 ≤ +@N {
    ++$j while @N[$j+1].defined and @N[$j+1] == @N[$i];
    @g.push(Group.new(:number(@N[$i]), :count($j-$i+1)));
    $i = ++$j;
}

my @G = [@g, 0],;
my $score = 0;

while True {
    my @G_;

    for ^+@G -> $i {
        my $groups = @G[$i][0];
        my $total = @G[$i][1];

        for ^+$groups -> $j {
            my $g_ = $groups[$j];

            my $score_ = $total + $g_.score;
            $score = $score_ if $score_ > $score;
            last if +$groups ≤ 1;

            # remove sequence after scoring
            my $groups_ = $groups.clone;
            $groups_.splice($j, 1);

            if 0 < $j < +$groups_ and $groups_[$j-1].number == $groups_[$j].number {
                # merge if possible
                $groups_[$j-1] = Group.new(:number($groups_[$j].number), :count($groups_[$j-1].count + $groups_[$j].count));   
                $groups_.splice($j, 1);
            }

            my $k = @G_.grep({ $_ eqv $groups }, :k).first;
            if $k.defined {
                # found duplicate
                @G_[$k][1] = max(@G_[$k][1], $score_);
            } else {
                @G_.push([$groups_, $score_]);
            }
        }
    }

    last unless +@G_;
    @G = @G_;
}

put $score;
