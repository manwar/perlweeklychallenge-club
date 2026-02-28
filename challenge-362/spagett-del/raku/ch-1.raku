sub echo-chamber(Str $text) {
    my $output = "";
    for $text.comb.kv -> $i, $char {
        $output ~= $char x ($i + 1);
    }
    return $output;
}

my @tc_input  = <abca xyz code hello a>;
my @tc_output = <abbcccaaaa xyyzzz coodddeeee heelllllllooooo a>;

for @tc_input Z @tc_output -> ($tci, $tco) {
    my $output = echo-chamber($tci);
    die "Test failed for $tci" unless $output eq $tco;
    say $output;
}