use v5.38;

sub proc($str) {
    say "Input: $str";
    my @letter = ('a' .. 'z');
    my $index = index $str, '?';
    my ($a, $b) = (substr($str, $index - 1, 1), substr($str, $index + 1, 1));
    my $current_ind = 0;
    my $next_letter = $letter[$current_ind];
    my $end_flag = 0;
    do {
	if ($next_letter eq $a || $next_letter eq $b) {
	    $current_ind++;
	    $next_letter = $letter[$current_ind];
	} else {
	    $end_flag = 1;
	}
    } while ($end_flag == 0);
    my ($pre, $post) = split '\?', $str;
    say "Output: ".$pre.$next_letter.$post;
}


my $str = "a?z";
proc($str);

$str = "pe?k";
proc($str);

$str = "gra?te";
proc($str);
