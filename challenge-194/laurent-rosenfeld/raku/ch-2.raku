sub remove-one ($st) {
    my %histo;
    %histo{$_}++ for $st.comb;
    my @frequencies = %histo.values.sort;
    my $largest = @frequencies.pop;
    return 1 if $largest - 1 == @frequencies.all;
    return 0;
}
for <abbc xyzyyxz xzxz> -> $test {
    say "$test.fmt("%-10s") => ", remove-one($test);
}
