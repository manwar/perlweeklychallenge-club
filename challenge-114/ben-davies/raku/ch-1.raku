use v6;
unit sub MAIN(IntStr:D $n) {
    say ($n^..*).first({ $^x eq $^x.flip });
}
