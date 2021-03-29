use v6;
unit sub MAIN(IntStr:D $n, IntStr:D $d) {
    say ($n / $d).base-repeating.reduce({ $^repeating ?? "$^base\($^repeating)" !! $^base });
}
