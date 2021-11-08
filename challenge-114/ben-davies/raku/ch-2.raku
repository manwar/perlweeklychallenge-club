use v6;
sub bits(Int:D $x --> Int:D) { + grep $x +> * +& 1, 0..$x.log2 }
unit sub MAIN(IntStr:D $n) {
    my Int:D $bits = $n.&bits;
    say $n && ($n^..*).first(*.&bits == $bits);
}
