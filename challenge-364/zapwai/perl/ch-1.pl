use v5.38;

my @la = qw( _ a b c d e f g h i );		  #(begins index at 1)
my @lb = qw( j k l m n o p q r s t u v w x y z ); #(add ten to index and append #)

sub decode(@v) {
    my $s;
    $s .= ($_ < 10) ? $la[$_] : $lb[$_ - 10] for (@v);
    $s
}

sub proc($s) {
    say "Input: \$str = \"$s\"";
    my @s = split '', $s;
    my @pindex = grep {'#' eq $s[$_]} (0 .. $#s);
    my @value;		      # stores strings, 1-9 or 10# through 26#
    my $i = 0;
    do {
	if (grep {$i + 2 == $_} @pindex) {
	    push @value, $s[$i].$s[$i+1];
	    $i += 3;
	} else {
	    push @value, $s[$i] unless (grep {$i == $_ || $i + 1 == $_} @pindex);
	    $i++;
	}
    } while ($i <= $#s);
    say "Output: " . decode(@value);
}

my $str = "10#11#12";
proc($str);
$str = "1326#";
proc($str);
$str = "25#24#123";
proc($str);
$str = "20#5";
proc($str);
$str = "1910#26#";
proc($str);
