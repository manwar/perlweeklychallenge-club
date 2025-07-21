use v5.38;
sub swappy($src, $tar) {
    my @s = split '', $src;
    for my $i (0 .. $#s - 1) {
	my @new = @s;
	my $a = $new[$i];
	$new[$i] = $new[$i+1];
	$new[$i+1] = $a;
	my $news = join '', @new;
	return 1 if ($news eq $tar);
    }
    return 0;
}

sub proc($src, $tar) {
    say "Input: $src, $tar";
    if (swappy($src, $tar)) {
	say "Output: true";
    } else {
	say "Output: false";
    }
}

my $src = "fcuk";
my $tar = "fuck";
proc($src, $tar);

$src = "love";
$tar = "love";
proc($src, $tar);

$src = "fodo";
$tar = "food";
proc($src, $tar);
