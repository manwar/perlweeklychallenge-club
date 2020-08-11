use v6;

my $string = "perlweeklychallenge";
my @words = <weekly challenge week perl>;
my %location;
for @words -> $word {
    my $index = index $string, $word;
    push %location, $word => $index if $index.defined;;
}
if %location.elems == 0 {
    say "0"
} else {
    print "{$_.key} " for %location.sort({.value});
}
