use v5.38;

sub proc($str, $char){
    say "Input: \$str = $str, \$char = $char";
    my @d = split '', $str;
    my @ind = grep { $d[$_] == $char } (0 .. $#d);
    my @l;
    foreach my $i (@ind) {
	my $new_num = substr($str, 0, $i) . substr($str, $i + 1);
	push @l, $new_num;
    }
    my $max = $l[0];
    for (0 .. $#l) {
	if ($max < $l[$_]) {
	    $max = $l[$_];
	}
    }
    say "Output: $max";
}

my $str = "15456"; my $char = "5";
proc($str, $char);
$str = "7332"; $char = "3";
proc($str, $char);
$str = "2231"; $char = "2";
proc($str, $char);
$str = "543251"; $char = "5";
proc($str, $char);
$str = "1921"; $char = "1";
proc($str, $char);
