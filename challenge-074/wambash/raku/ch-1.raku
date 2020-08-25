use v6;

sub majority-element (+@a) {
    @a.Bag
    andthen \(total => .total,  max-element => .max: *.value)
    andthen .<total> - .<max-element>.value < .<max-element>.value ?? .<max-element>.key !! -1
}

sub MAIN (:$test) {
    use Test;
    is majority-element(1, 2, 2, 3, 2, 4, 2),  2;
    is majority-element(1, 3, 1, 2, 4, 5),    -1;
    done-testing();
}
