use v6;

sub color($cell) {
    my ($letter, $number) = $cell.comb;
    my @letter = <a b c d e f g h >;
    $number--;
    my $letnum = @letter.first($letter, :k);
    return ($letnum + $number) %% 2 ?? "black" !! "white";
}

sub proc($c1, $c2) {
    say "Input: \$c1 = $c1, \$c2 = $c2";
    say "Output: ", color($c1) eq color($c2) ?? "true" !! "false";
}

my $c1 = "a7"; my $c2 = "f4";
proc($c1, $c2);
$c1 = "c1"; $c2 = "e8";
proc($c1, $c2);
$c1 = "b5"; $c2 = "h2";
proc($c1, $c2);
$c1 = "f3"; $c2 = "h1";
proc($c1, $c2);
$c1 = "a1"; $c2 = "g8";
proc($c1, $c2);
