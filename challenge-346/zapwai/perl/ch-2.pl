use v5.38;
sub proc($str, $target) {
    say "Input: $str, $target";
    my @num = split '', $str;

    # This is the single digits case only.
    # The general version would include (len choose n) cases as n runs from 2 to len - 1
    # I might upload a more general version later in the week, if I get a chance
    
    my @out;
    my @s = ('+', '-', '*');

    for my $symb (@s) {
	push @out, $num[0].$symb;
    }

    for my $i (1 .. $#num - 1) {
	my @a;
	for my $symb (@s) {
	    push @a, $_.$num[$i].$symb for (@out);
	}
	@out = @a;
    }

    my @a;
    push @a, $_.$num[$#num] for (@out);
    say "Output: ";
    for my $a (@a) {
	my $ans = eval($a);
	say "\t$a = ".$ans if ($ans == $target);
    }
    
}

my $str = "123"; my $target = 6;
proc ($str, $target);
$str = "105"; $target = 5;
proc ($str, $target);
$str = "232"; $target = 8;
proc ($str, $target);
$str = "1234"; $target = 10;
proc ($str, $target);
$str = "1001"; $target = 2;
proc ($str, $target);
