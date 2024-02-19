use v5.30;

my $str1a = "abcd"; my $str2a = "1234";
my $str1b = "abc"; my $str2b = "12345";
my $str1c = "abcde"; my $str2c = "123";

proc($str1a,$str2a);
proc($str1b,$str2b);
proc($str1c,$str2c);

sub proc {
    my $s1 = shift;
    my $s2 = shift;
    say "Input: \$s1 = $s1, \$s2 = $s2";
    print "Output: ";
    say merge($s1, $s2);
}

sub merge {
    my $str1 = shift;
    my $str2 = shift;

    my $s;
    my @a = split("", $str1);
    my @b = split("", $str2);

    my $M = ($#a > $#b) ? $#a : $#b;
    for (0 .. $M) {
	$s .= $a[$_].$b[$_];    
    }
    return $s;
}
