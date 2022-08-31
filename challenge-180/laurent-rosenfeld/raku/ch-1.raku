for "Perl Weekly Challenge", "Long Live Perl" -> $test {
    my @let = $test.comb;
    my %h;      # histogram of letters
    %h{$_}++ for @let;
    say "$test: $_" and last if %h{@let[$_]} == 1 for 0..@let.end;
}
