use v5.38;
my $s = "This supposed Cambridge research is unfortunately an urban legend";
proc($s);
sub jumble($word) {
    return $word if (length $word < 4);
    my @let = split "", $word;
    my $start = $let[0];
    my $end = $let[$#let];
    pop @let;
    shift @let;
    my @order;
    while (@order < @let) {
	my $x = int rand @let;
	push @order, $x unless (grep {$_ == $x} (@order));
    }
    my $middle;
    $middle .= $let[$_] for (@order);
    my $q = $start . $middle . $end;
    return $q;
}

sub proc($s) {
    say "Input: $s";
    my @words = split " ", $s;
    my @new = map {jumble($_)} (@words);
    say "Output: @new";
}
