use v6;

sub visit ($row, $col, $path) {
    print "$path " and return if $row == $col == $*end;
    visit($row + 1, $col + 1, "{$path}R") if $row < $*end and $col < $*end;
    visit($row, $col + 1, "{$path}H") if $col < $row;
    visit($row + 1, $col, "{$path}L") if $row < $*end;
}

sub MAIN(UInt $size = 3) {
    my $*end = $size;
    visit(0, 0, '');
}
