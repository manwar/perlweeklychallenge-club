#!/usr/bin/env raku


multi prime-factors(1) { Bag() }
multi prime-factors($n where *.is-prime) { Bag($n) }
multi prime-factors($n) { (2..sqrt $n).first: $n %% * andthen $_ (+) prime-factors($n div $_)}

sub is-weird($n) {
  when $n == 0|1 { False }
  my @proper-divisors = prime-factors($n).kxxv.combinations.map(*.reduce: &[*]).unique.grep: * != $n;
  @proper-divisors.combinations.map(&sum).categorize(* cmp $n) andthen .{Same, More}:exists eqv (False, True);
}

my $n = prompt 'Input: $n = ';
say "Output: {is-weird($n).Int}";
