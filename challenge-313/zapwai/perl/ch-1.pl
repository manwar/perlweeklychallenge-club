use v5.38;
sub proc($name, $typed) {
    say "Input: \$name = $name, \$typed = $typed";
    my @l = split '', $name;
    my @m = split '', $typed;
    my $bad = 0;
    if (@l > @m) {
	$bad = 1;
    } else {
	my $ind = 0;
	my $rep_flag = 0;
	for my $i (0 .. $#l) {
	    my $letter = $l[$i];

	    $rep_flag = 0;
	    my $next_letter;
	    if ($i < $#l) {
		$next_letter = $l[$i+1];
	    }
	    if ($i < $#l && $next_letter eq $letter) {
		$rep_flag = 1;
	    }
	    my $letter2 = $m[$ind];
	    if ($letter2 ne $letter) {
		$bad = 1;
		last;
	    } else {
		if ($rep_flag) {
		    $ind++;
		} else {
		    do {
			$letter2 = $m[++$ind] // 0;
		    } while (($letter2 eq $letter) && $ind < $#m);
		}
	    }
	}
    }
    say "Output: ", ($bad == 0) ? 'true' : 'false';
}

my $name = "perl"; my $typed = "perrrl";
proc($name, $typed);
$name = "raku"; $typed = "rrakuuuu";
proc($name, $typed);
$name = "python"; $typed = "perl";
proc($name, $typed);
$name = "coffeescript";$typed = "cofffeescccript";
proc($name, $typed);
$name = "raku"; $typed = "ruaku";
proc($name, $typed);
