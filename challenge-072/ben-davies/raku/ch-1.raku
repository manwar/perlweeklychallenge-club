use v6;
unit sub MAIN(Int:D $n where 1 <= * <= 10) {
    my Int:D $n-factorial     = ($n...1).reduce(* * *);
    my Int:D $trailing-zeroes = +(10,* * 10...^$n-factorial !%% *);
    say "$n as $n! = $n-factorial has $trailing-zeroes trailing zeroes";
}
