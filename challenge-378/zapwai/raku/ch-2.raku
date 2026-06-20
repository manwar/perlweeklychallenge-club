use v6;
my $alph = "abcdefghij";

sub convert($s) {
    return $s.comb.map({index($alph, $_)}).join('');
}

sub proc($s1, $s2, $s3) {
    say "Input: $s1, $s2, $s3";
    my $sum = convert($s1) + convert($s2);
    say "Output: ", $sum == convert($s3) ?? "true" !! "false";
}

my $str1 = "acb"; my $str2 = "cba"; my $str3 = "cdb";
proc($str1, $str2, $str3);
$str1 = "aab"; $str2 = "aac"; $str3 = "ad";
proc($str1, $str2, $str3);
$str1 = "bc"; $str2 = "je"; $str3 = "jg";
proc($str1, $str2, $str3);
$str1 = "a"; $str2 = "aaaa"; $str3 = "aa";
proc($str1, $str2, $str3);
$str1 = "c"; $str2 = "d"; $str3 = "h";
proc($str1, $str2, $str3);
$str1 = "gfi"; $str2 = "hbf"; $str3 = "bdhd";
proc($str1, $str2, $str3);
