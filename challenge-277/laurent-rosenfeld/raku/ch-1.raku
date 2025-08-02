sub count-common (@in1, @in2) {
    my $bag-in1 = @in1.Bag;
    my $bag-in2 = @in2.Bag;
    my $unique1 = grep {$bag-in1{$_} == 1}, $bag-in1.keys;  .
    my $unique2 = grep {$bag-in2{$_} == 1}, $bag-in2.keys;
    return ($unique1 ∩ $unique2).elems;
}

my @tests = ( <Perl is my friend>,
              <Perl and Raku are friend> ),
            ( <Perl is my friend>,
              <Raku is friend of my friend Perl> ),
            ( <Perl and Python are very similar>,
              <Python is top in guest languages> ),
            ( <Perl is imperative Lisp is functional>,
              <Crystal is similar to Ruby> );

for @tests -> @test {
    say @test[0];
    say @test[1];
    say count-common @test[0], @test[1];
    say "";
}
