#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @intervals = @args.map({ [ $_.split(/\s+/) ] });

    my %startIndices = @intervals.kv.map( -> $k, $v { @$v[0] => $k });
    my @starts = @intervals.map({ @$_[0] }).sort({ $^a <=> $^b });
    my @result;

    for @intervals -> $interval {
        my $end = $interval[1];
        my $rightInterval = @starts.first(* >= $end);

        if $rightInterval.defined {
            @result.push(%startIndices{$rightInterval});
        } else {
            @result.push(-1);
        }
    }

    say q{(}, @result.join(q{, }), q{)};
}
