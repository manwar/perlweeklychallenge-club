class Calc {

    has $foo;

    method add ($a, $b) {}
    method sub ($a, $b) {}
    method mul ($a, $b) {}
    method div ($a, $b) {}

}


package main {

    my @m = Calc.^methods();
    .say for @m;
}
