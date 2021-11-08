#| natural numbers that don't contain digit 1
sub MAIN(UInt $N where * > 1) {
    print .join: ', ' with (1..$N).hyper.grep(*.comb.grep(1).elems == 0);
    put '.';
}
