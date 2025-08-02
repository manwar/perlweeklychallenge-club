use v5.38;
use List::Util qw( uniq );

sub proc($str) {
    say "Input: $str";
    my @l = split '', $str;
    for my $i (0 .. $#l) {
	if ($l[$i] =~ /[a-zA-Z]/) {
	    $l[$i] = ' ';
	}
    }
    my $s = join '', @l;
    $s =~ s/ +/ /;
    my @o = split " ", $s;
    my @u = uniq(@o);
    say "Output: @u";
}


my $str = "the1weekly2challenge2";
proc($str);

$str = "go21od1lu5c7k";
proc($str);

$str = "4p3e2r1l";
proc($str);
