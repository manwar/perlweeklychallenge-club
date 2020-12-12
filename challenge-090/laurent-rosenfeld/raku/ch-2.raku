use v6;

my ($a, $b) = map {$_.Int}, @*ARGS;
my $result = $a % 2 ?? $b !! 0;
while $a > 1 {
    $a div= 2;
    $b *= 2;
    $result += $b if $a % 2;
}
say $result;
