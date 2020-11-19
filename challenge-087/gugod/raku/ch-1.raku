
sub MAIN() {
    say longest-consecutive-sequence([9,1,2,7,8,84]) // 0;
    say longest-consecutive-sequence([2,1,3,9,7,8,4]) // 0;
    say longest-consecutive-sequence([2,1,2,3,9,7,8,4]) // 0;
}

sub longest-consecutive-sequence(@N) {
    my @m = @N.sort({ $^a <=> $^b });

    my $seq_from = @m[0];
    my $seq_until = @m[0];
    my $longest_seq_from = @m[0];
    my $longest_seq_until = @m[0];
    my $longest_seq_length = 0;

    for 1..@m.end -> $i {
        my $n = @m[$i];
        if $n - @m[$i-1] == 0|1 {
            $seq_until = $n;
            my $len = $seq_until - $seq_from;
            if $longest_seq_length < $len {
                $longest_seq_from   = $seq_from;
                $longest_seq_until  = $seq_until;
                $longest_seq_length = $len;
            }
        } else {
            $seq_from  = $n;
            $seq_until = $n;
        }
    }

    return $longest_seq_length == 0 ?? Nil !! [$longest_seq_from...$longest_seq_until];
}

