use v5.38;
my $str = 'aBc 11c';
my @str = ('accbbb', 'abc', 'abbc');
proc($str, @str);

$str = 'La1 abc';
@str = ('abcl', 'baacl', 'abaalc');
proc($str, @str);

$str = 'JB 007';
@str = ('jj', 'bb', 'bjb');
proc($str, @str);

sub freq($str) {
    my %f;
    foreach (split "", $str) {
	next unless (/\w/ && /[^0-9]/);
	$f{lc $_}++;
    }
    return \%f;
}

# Return 1 if g contains f
sub hash_contains($g, $f) {
    my %g = %$g;
    my %f = %$f;
    my $cnt = scalar grep {$f{$_} <= $g{$_}} (keys %f);
    return ($cnt == scalar keys %f);
}

sub proc($str, @str) {
    say "Input:  \$str = $str";
    say "\t\@str = @str";
    my @ans = grep { hash_contains(freq($_), freq($str)) } (@str);
    my $min = length $ans[0];
    my $answer = $ans[0] // 0;
    foreach my $i (0 .. $#ans) {
	if (length $ans[$i] < $min) {
	    $min = length $ans[$i];
	    $answer = $ans[$i];
	}
    }
    say "Output: $answer";
}
