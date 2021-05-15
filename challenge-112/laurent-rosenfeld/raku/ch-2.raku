use v6;

sub print-result {
    my $count = 0;
    for  @*result -> @solution {
        print "\tOption ", ++$count, ": ";
        my @step_list;
        push @step_list, "$_ " ~ ($_ ~~ /1/ ?? "step " !! "steps") for @solution;
        say join " + ", @step_list;
    }
    say "";
}

sub try-steps ($nb-steps, @curr) {
    for 1, 2 -> $new-step {
        my @new-cur = (|@curr, $new-step);
        my $sum = [+] @new-cur;
        next if $sum > $nb-steps;
        if $sum == $nb-steps {
            push @*result, @new-cur;
            last;
        } else {
            try-steps $nb-steps, @new-cur;
        }
    }
}

for 3, 4, 5 -> $target {
    my @*result;
    try-steps $target, [];
    say 'Input: $n = ', $target;
    say "Output: ", @*result.elems;
    # say @*result;
    print-result;
}
