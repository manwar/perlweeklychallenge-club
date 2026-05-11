use v5.38;

sub proc($s) {
    say "Input : \"$s\"";
    my @word = split ' ', $s;
    my $space_counter = 0;
    for my $letter (split '', $s) {
	$space_counter++ if ($letter eq " ");
    }
    my $out = "";
    if (@word == 1) {
	$out = $word[0];
	$out .= " " x $space_counter;
    } else {
	my $gap = @word - 1;
	my $gap_space = $space_counter / $gap;
	my $rem_space = $space_counter % $gap;
	for my $i (0 .. $#word - 1) {
	    $out .= $word[$i];
	    $out .= " " x $gap_space;
	}
	$out .= $word[$#word];
	$out .= " " x $rem_space;
    }
    say "Output: \"$out\"";
}

my $s = "  challenge  ";
proc($s);
$s = "coding  is  fun";
proc($s);
$s = "a b c  d";
proc($s);
$s = "  team      pwc  ";
proc($s);
$s = "   the  weekly  challenge  ";
proc($s);
