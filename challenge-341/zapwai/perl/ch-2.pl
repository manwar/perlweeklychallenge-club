use v5.38;

sub proc($s, $c) {
    say "Input: \$str = $s, \$char = $c";
    my $ind = index $s, $c;
    my $pre = substr $s, 0, $ind + 1;
    my $post = substr $s, $ind + 1;
    print "Output: ";
    print scalar reverse $pre;
    say $post;
}

my $s = "programming";
my $c = "g";
proc($s, $c);

$s = "hello";
$c = "h";
proc($s, $c);

$s = "abcdefghij"; $c = "h";
proc($s, $c);

$s = "reverse"; $c = "s";
proc($s, $c);

$s = "perl"; $c = "r";
proc($s, $c);
