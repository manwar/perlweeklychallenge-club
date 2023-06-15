my @words2 = ("hello", "world", "challenge");
my $chars2 = "welldonehopper";
my @words1 = ("cat", "bt", "hat", "tree");
my $chars1 = "atach";

my @wlist = (@words1, @words2);
my @clist = ($chars1, $chars2);

for (0 .. 1) {
    my @words;
    for @wlist[$_][0..@wlist[$_].elems - 1] -> $w {
	push @words, $w
    }
    my $chars = @clist[$_];
    my %c = fill_hash($chars);
    my $sum;
    $sum += contrib($_, %c) for @words;
    say "Input: \@words = (" ~ join(",",@words) ~ ")";
    say " " x 7 ~ "\$chars = $chars";
    say "Output: $sum";

}
sub contrib ($word, %c) {
    my %w = fill_hash($word);    
    for %w.keys -> $key {
	return 0 unless %c{$key};
	my $val = %c{$key} - %w{$key};
	return 0 if $val < 0;
    }
    return $word.chars;
}
sub fill_hash (Str $str) {
    my @W = split("", $str, :skip-empty);
    my %h;
    %h{$_}++ for @W;
    %h
}
