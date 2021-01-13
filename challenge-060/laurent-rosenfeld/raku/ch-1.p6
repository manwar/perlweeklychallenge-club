use v6;

constant \MAX = 16_384;
my @cols = '', 'A', 'B' ... *;
my %nums = map { @cols[$_] => $_}, 1..MAX;

multi sub MAIN (Int $n = 28) {
    say "Column $n = @cols[$n]";
}

multi sub MAIN (Str $col-name where * ~~ /^<[A..Z]>+$/) {
    say "Column $col-name = %nums{$col-name}";
}
