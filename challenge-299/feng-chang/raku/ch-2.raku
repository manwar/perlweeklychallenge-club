#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.f = 'data-01.txt');

my (\s1, $word) = $f.IO.slurp.split("\n\n");

my @m = s1.lines.map({ .comb.Array });
my (\rows, \cols) = +@m, +@m[0];

$word .= chomp;
put find-word($word, @m);

sub in-bound(Int:D \row, Int:D \col --> Bool:D) {
    0 ≤ row < rows && 0 ≤ col < cols
}

sub find-word-from(Str:D $word, UInt:D \row, UInt:D \col, @m --> Bool:D) {
    return True unless $word;

    my $c = $word.substr(0, 1);
    so ([-1,0], [1,0], [0,-1], [0,1]).map(-> $step {
        my (\row_, \col_) = row+$step[0], col+$step[1];
        next unless in-bound(row_, col_);
        next unless @m[row_;col_] eq $c;

        my @m_ = @m.deepmap(*.clone);
        @m_[row_;col_] := '.';
        find-word-from($word.substr(1), row_, col_, @m_)
    }).any
}

sub find-word(Str:D $word, @m --> Bool:D) {
    return True unless $word;

    with @m[*;*].grep($word.substr(0, 1), :k) {
        so .map(-> \pos {
            my (\row, \col) = pos div cols, pos % cols;
            my @m_ = @m.deepmap(*.clone);
            @m_[row;col] := '.';
            find-word-from($word.substr(1), row, col, @m_)
        }).any
    } else {
        False
    }
}
