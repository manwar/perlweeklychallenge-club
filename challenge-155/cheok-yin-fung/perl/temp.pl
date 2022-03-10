sub pisano_period {
    my ($N, $t, $rec, $seq) = @_;
    die "(Some of) Parameters are too large.\n"
        if $N**$t + $t - 1 > 8_000_000;

    my $ori_seqstate = [map {$_ % $N} @$seq];
    my $new_seqstate = [@$ori_seqstate];
    my $count = 0;
    do { 
        my $new_val = sum map {$rec->[$_]*$new->[$_]} (0..$t-1);
        $new_val = $new_val % $N;
        push @{$seq}, $new_val;
        shift @{$new_seqstate};
        push @{$new_seqstate}, $new_val;
        $count++;
        die "Patterns not found\n" if $count > $N**$t + $t;
    } while (!cmp_num_arr($new_seqstate, $ori_seqstate));

    return [@$seq[0..$count-1]];
}
