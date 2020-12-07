subset PositiveInt of UInt where * > 0;

multi MAIN(PositiveInt $A, PositiveInt $B) { #= where A and B are Ints > 0
   say ethiopian-product(+$A, +$B);
}
 
multi MAIN {
    use Test;
    plan 2;
    
    ok ethiopian-product(14, 12) == 14 * 12, "14 * 12 == {14 * 12}";

    ok ethiopian-product(12, 14) == 12 * 14, "12 * 14 == {12 * 14}";
}

sub ethiopian-product(PositiveInt $A, PositiveInt $B) {
    my $factors1 = ($A, $A/2, $A/4 ... 1).map(*.floor);

    my $factors2 = ($B, $B*2, $B*4 ... *).head($factors1);

    my @indices = $factors1.grep(* mod 2, :k);

    sum $factors2[@indices];
}
