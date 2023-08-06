 #!/usr/bin/env raku

sub unique-sum (+int) {
    int
    andthen .Bag
    andthen .nodemap:  * == 1
    andthen .keys
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is unique-sum(2,1,3,2),  4;
    is unique-sum(1,1,1,1),  0;
    is unique-sum(2,1,3,4), 10;
    done-testing;
}

multi MAIN (+int) {
    say unique-sum int
}
