my $base = 35;
my $result = '';
my $current = $ARGV[0];
while ($current > 0) {
    $result = (0 .. 9, 'A' .. 'Y')[$current % $base].$result;
    $current = int($current / $base);
}
print "$result\n";
