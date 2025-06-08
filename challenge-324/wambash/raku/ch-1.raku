sub two-d-array (+ints,:$row,:$col) {
    ints
    andthen .batch: $col
    andthen .head: $row
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply two-d-array(^4+1):2row:2col, ((1,2),(3,4));
    is-deeply two-d-array(^3+1):1row:3col, ((1,2,3),);
    is-deeply two-d-array(^4+1):4row:1col, ((1,),(2,),(3,),(4,));
    done-testing;
}

multi MAIN (+ints,:$row,:$col) {
    say two-d-array ints,:$row,:$col;
}
