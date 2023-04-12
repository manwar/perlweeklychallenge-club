use v5.30.0;
no warnings;
my @list = (1,2,3,5,1,2,7,6,3) ;
#my @list = (1,2,4,3,5,3);
#my @list = (1,2,3);
#my @list = (1,5,2,6,4,7);
my $size = 3;
say "Input: \@list: (".join(",",@list).") and \$size: $size";
@list = sort @list;
my $output = -1;
if ( ($#list + 1) % $size == 0 ) {
    $output = "";
    my $cnt;
    my $j = 0;
    while ($j < $#list) {
	for my $i (1 .. $size - 1) {
	    if ($list[$j] + $i ~~ @list) {
		$cnt++;
		my $ind = array_search($list[$j] + $i, @list);
		splice @list, $ind, 1;
	    }
	}
	if ($cnt == $size - 1) {
	    my @a = ($list[$j]..$list[$j] + $size - 1);
	    $output .= "(".join(",",@a).") "; 
	    shift @list;
	} else {
	    $output = "-1";
	    last;
	}
	$cnt = 0;
    } 
}
$output = substr $output, 0, -1 unless ($output eq '-1');
say "Output: $output";
# Shamelessly stolen from stack exchange bc I liked it
sub array_search { my ($element, @array) = @_; foreach (0..$#array) { if ($array[$_] eq $element) { return $_; } } return -1; }
