sub pascal ($nb-rows) {
    my @line = 1,;
    for 1 .. $nb-rows -> $row {
        @line.join(" ").say;
        @line = flat 1, (map {@line[$_] + @line[$_ + 1]}, 0 .. $row - 2), 1;
    }
}
sub MAIN (Int $rows where * > 0) {
    pascal $rows
}
