use v6;

sub proc($s) {
    say "Input: \"$s\"";
    my $sp_cnt = $s.comb(/\s/).elems;
    my @word = $s.words;
    my $gap_sp = @word.elems == 1 ?? 0 !! $sp_cnt div @word.end;
    my $rem_sp = @word.elems == 1 ?? $sp_cnt !! $sp_cnt % @word.end;
    my $out = @word.join(' ' x $gap_sp) ~ ' ' x $rem_sp;
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
