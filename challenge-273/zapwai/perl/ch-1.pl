use v5.38;
my $str = "perl"; my $char = "e";
proc($str, $char);
$str = "java"; $char = "a";
proc($str, $char);
$str = "python"; $char = "m";
proc($str, $char);
$str = "ada"; $char = "a";
proc($str, $char);
$str = "ballerina"; $char = "l";
proc($str, $char);
$str = "analitik"; $char = "k";
proc($str, $char);    

sub proc($str, $char) {
    say "Input: \$str = $str, \$char = $char";
    my $cnt = grep { $_ eq $char } split "", $str;
    my $i = int 100*($cnt / length $str);
    my $r = 100*($cnt / length $str) - $i;
    $i++ if ($r >= .5);
    say "Output: $i";
}
