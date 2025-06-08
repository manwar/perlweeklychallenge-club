sub total-xor (+ints) {
    ints
    andthen .combinations: 1..*
    andthen .map: {[+^] $_}\
    andthen .sum                      
}

multi MAIN (Bool :test($)!) {
    use Test;
    is total-xor(1,3), 6;
    is total-xor(5,1,6), 28;
    is total-xor(3..8), 480;
    is total-xor(^11), 15360;
    done-testing;
}

multi MAIN (+ints) {
    say total-xor ints;
}
