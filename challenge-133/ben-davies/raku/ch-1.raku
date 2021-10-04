use v6;
unit sub MAIN(Int:D $n where * > 0) {
    say (1..$n).first({ $^x == $n div $^x });
}
