 #!/usr/bin/env raku

sub complete-day (+hours) {
    hours
    andthen .combinations: 2
    andthen .grep: *.sum %% 24
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is complete-day(12,12,30,24,24),2;
    is complete-day(12,12,36,24,24),4;
    is complete-day(72,48,24,5),3;
    is complete-day(12,18,24),0;
    done-testing;
}

multi MAIN (+hours) {
    say complete-day hours
}
