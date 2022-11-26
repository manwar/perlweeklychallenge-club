#!/usr/bin/env raku

subset Choice of List where ((Int, Int), Int);

sub next-placement(@normal-values) {
  @normal-values.pairs.grep(*.value != 0).rotor(2 => -1).grep({ [!=] $_>>.value>>.sign }) andthen .so ?? .min({ [R-] $_>>.key }) !! Nil
}

multi dist-steps(@ where { .sum !%% .elems } ) { -1 }
multi dist-steps(@list) {
  my $average = @list.sum div +@list;
  my @norm-list = @list >>->> $average;
  my @costs = gather while @norm-list.&next-placement -> $endpoints {
    my $moved-amount = $endpoints.>>.value>>.abs.min;
    my $distance = [R-] $endpoints>>.key;
    take $moved-amount * $distance;
    $_ -= $moved-amount * .sign for $endpoints>>.value;
  };
  @costs.sum
}

my token natural-number { 0 | <[1..9]> <[0..9]>* }
subset NatList of Str where /^ '(' <natural-number>* % [\s* ',' \s*] ')' $/;
sub MAIN($n) {
  die 'Please provide a valid list of natural numbers' unless $n ~~ NatList;
  my @list = $<natural-number>>>.Int;
  @list.&dist-steps.say;
}