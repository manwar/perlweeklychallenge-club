use v6;

sub proc($s1, $s2) {
    say "Input:  \$s1 = $s1\n\t\$s2 = $s2";
    my %h;
    my @w1 = split ' ', $s1;
    my @w2 = split ' ', $s2;
    %h{$_}++ for @w1;
    %h{$_}++ for @w2;
    my @out;
    for keys %h -> $key {
	push @out, $key if %h{$key} == 1;
    }
    say "Output: " ~ @out;
}

my $s1 = "apple banana apple";
my $s2 = "banana orange";
proc($s1, $s2);

$s1 = "cat dog";
$s2 = "bird fish";
proc($s1, $s2);

$s1 = "the quick brown fox";
$s2 = "the quick";
proc($s1, $s2);

$s1 = "hello";
$s2 = "hello";
proc($s1, $s2);

$s1 = "blue blue red";
$s2 = "red green green yellow";
proc($s1, $s2);
