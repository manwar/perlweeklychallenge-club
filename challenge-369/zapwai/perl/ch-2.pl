use v5.38;
use POSIX "ceil";

sub proc($str, $size, $filler){
    say "Input: \$str = $str, \$size = $size, \$filler = $filler";
    my $cnt = ceil(length($str) / $size);
    my $r = length($str) % $size;
    my $fill_cnt = $size - $r;
    say "Output:";
    for (0 .. $cnt - 1) {
	print "\t", substr($str, $_*$size, $size);
	if ($_ == $cnt - 1 && $r != 0) {
	    say $filler x $fill_cnt;
	} else {
	    say "";
	}
    }
    
}

my $str = "RakuPerl"; my $size = 4; my $filler = "*";
proc($str, $size, $filler);
$str = "Python"; $size = 5; $filler = "0";
proc($str, $size, $filler);
$str = "12345"; $size = 3; $filler = "x";
proc($str, $size, $filler);
$str = "HelloWorld"; $size = 3; $filler = "_";
proc($str, $size, $filler);
$str = "AI"; $size = 5; $filler = "!";
proc($str, $size, $filler);
