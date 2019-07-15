use v6;
subset Positive of Int where * >= 0;

multi ack (0, Positive \n) { n + 1 }
multi ack (Positive \m, 0) { ack(m - 1, 1) }
multi ack (Positive \m, Positive \n) {
    ack(m - 1, ack(m, n - 1))
}
sub MAIN (Positive \m, Positive \n) {
    say ack +m, +n;
}
