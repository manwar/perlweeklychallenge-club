#!/usr/bin/raku

sub makePath($currRow, $currCol, $endRow, $endCol, $path) {
    if $currRow == $endRow && $currCol == $endCol {
        say $path;
        return;
    }

    # go left
    if ($currRow < $endRow) {
        makePath($currRow + 1, $currCol, $endRow, $endCol, $path ~ 'L');
    }

    # go horizontal
    if ($currCol < $currRow) {
        makePath($currRow, $currCol + 1, $endRow, $endCol, $path ~ 'H');
    }

    # go right
    if $currRow < $endRow && $currCol < $endCol {
        makePath($currRow + 1, $currCol + 1, $endRow, $endCol, $path ~ 'R');
    }
}

sub MAIN(Int $N) {
    makePath(0, 0, $N, $N, q{});
}