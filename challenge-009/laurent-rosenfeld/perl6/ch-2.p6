use v6;

sub standard (%scores) {
    my ($prev_rank, $prev_val, $rank, $rankings ) = 0, 0, 0, "";
    for sort {%scores{$_}}, keys %scores -> $key {
        $rank++;
        if (%scores{$key} > $prev_val) {
            $rankings ~= "$rank\t$key\t%scores{$key}\n";
            $prev_rank = $rank;
        } else {
            $rankings ~= "$prev_rank\t$key\t%scores{$key}\n";
        }
        $prev_val =  %scores{$key};
    }
    return $rankings;
}

sub modified (%scores) {
    my ($prev_val, $rank, @rankings, @buffer) = 0, 0;
    for sort {%scores{$_}}, keys %scores -> $key {
        $rank++;
        if (%scores{$key} > $prev_val) {
            push @rankings, ($rank - 1 ~ $_) for @buffer;
            @buffer = ("\t$key\t%scores{$key}");
        } else {
            push @buffer, "\t$key\t%scores{$key}";
        }
        $prev_val =  %scores{$key};
    }
    push @rankings, ($rank ~ $_) for @buffer;
    return join "\n", @rankings;
}

sub dense (%scores) {
    my ($prev_rank, $prev_val, $rank, $rankings) = 0, 0, 0, "";
    for sort {%scores{$_}}, keys %scores -> $key {
        if (%scores{$key} > $prev_val) {
            $rank++;
            $rankings ~= "$rank\t$key\t%scores{$key}\n";
            $prev_rank = $rank;
        } else {
            $rankings ~= "$prev_rank\t$key\t%scores{$key}\n";
        }
        $prev_val =  %scores{$key};
    }
    return $rankings;
}

my %scores = a => 4, b => 5, c => 3, d => 5, e => 1, f => 4, g => 6, h => 4, i =>6;

my $head = "Rank\tID\tScore";
.say for  "      Standard", $head, standard(%scores);
.say for "\n      Modified", $head, modified(%scores);
.say for "\n      Dense", $head, dense(%scores);
