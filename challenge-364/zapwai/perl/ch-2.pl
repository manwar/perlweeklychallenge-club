use v5.38;

sub proc($s) {
    say "Input: \$str = $s";
    $s =~ s/\(\)/o/g;
    $s =~ s/\(al\)/al/g;
    say $s;
}

my $str = "G()(al)";
proc($str);
$str = "G()()()()(al)";
proc($str);
$str = "(al)G(al)()()";
proc($str);
$str = "()G()G";
proc($str);
$str = "(al)(al)G()()";
proc($str);
