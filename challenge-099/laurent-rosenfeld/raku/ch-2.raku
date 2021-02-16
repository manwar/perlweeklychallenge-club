use v6;

my @input-tests = [ "littleit", "lit"], ["london", "lon"];

for @input-tests -> $test {
    my ($in, $substr) = $test[0..1];
    say "$test: ", search-substr $in, $substr;
}
sub search-substr (Str $in, Str $substr) {
    my @results = $in.comb.combinations($substr.\
        chars)>>.join("").grep({$_ eq $substr}).elems;
}
