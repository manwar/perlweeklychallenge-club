multi MAIN(*@R where .all > 0) {
    say triplet-sum(@R)
}
 
multi MAIN {
    use Test;
    plan 3;

    ok triplet-sum([1.2, 0.4, 0.1, 2.5]) == 1, "Example 1";
    ok triplet-sum([0.2, 1.5, 0.9, 1.1]) == 0, "Example 2";
    ok triplet-sum([0.5, 1.1, 0.3, 0.7]) == 1, "Example 3";
}
   
sub triplet-sum(@R) {
    @R.grep(* < 2)
      .combinations(3)
      .map(*.sum)
      .first(1 < * < 2)
      .Bool 
      .UInt 
}
