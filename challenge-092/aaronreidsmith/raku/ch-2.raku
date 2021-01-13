#!/usr/bin/env raku

subset MultiRange of Str where { $_ ~~ /^[<digit>+'-'<digit>+',']+[<digit>+'-'<digit>+]$/ }
subset Range of Str where { $_ ~~ /^<digit>+'-'<digit>+$/ }

sub challenge(@S, $N) {
    my @combined = (|@S, $N).sort({ $^a.min cmp $^b.min });
    my @final = (@combined.head,);
    OUT: for @combined[1..*] -> $new-range {
        my ($min, $max) = $new-range.minmax;
        IN: for @final.kv -> $index, $range {
            next IN if $min ∈ $range && $max ∈ $range;
            if $min ∈ $range {
                @final[$index] = ($range.min..$max);
                next OUT;
            } elsif $max ∈ $range {
                @final[$index] = ($min..$range.max);
                next OUT;
            } elsif $index == @final.end {
                @final.push($new-range);
            }
        }
    }
    @final.map(-> $range { "({$range.min},{$range.max})" }).join(', ');
}

multi sub MAIN(MultiRange :$S, Range :$N) {
    my @s = $S.split(',').map(*.split('-').map(*.Int).minmax);
    my $n = $N.split('-').map(*.Int).minmax;
    say challenge(@s, $n);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ((1..4), (8..10), (2..6), '(1,6), (8,10)'),
        ((1..2), (3..7), (8..10), (5..8), '(1,2), (3,10)'),
        ((1..5), (7..9), (10..11), '(1,5), (7,9), (10,11)')
    );

    for @tests -> @test {
        my @S = @test[0..^*-2];
        my $N = @test[*-2];
        my $answer = @test[*-1];
        is(challenge(@S, $N), $answer);
    }

    done-testing;
}
