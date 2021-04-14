constant \MAX = 9;
my @tr;
@tr[0][0] = 1;
for 1..MAX -> $row {
    @tr[$row][0] = @tr[$row - 1][*-1];
    for 1..$row -> $i {
        @tr[$row][$i] = @tr[$row][$i-1] + @tr[$row - 1][$i-1];
    }
}
say join " ", map { @tr[$_][0] }, 0..@tr.end;
