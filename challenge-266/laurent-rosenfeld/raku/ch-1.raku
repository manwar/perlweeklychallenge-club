sub uncommon ($in1, $in2) {
    my $out = $in1.words ⊎ $in2.words; # Baggy addition
    return grep {$out{$_} == 1}, $out.keys;
}

my @tests = ('Mango is sweet', 'Mango is sour'),
            ('Mango Mango', 'Orange'),
            ('Mango is Mango', 'Orange is Orange');
for @tests -> @test {
    printf "%-18s - %-18s => ", @test[0], @test[1];
    say uncommon @test[0], @test[1];
}
