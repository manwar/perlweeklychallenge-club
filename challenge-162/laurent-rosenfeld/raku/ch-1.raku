my $isbn = "978-0-306-40615-";
my $sum = 0;
for $isbn.comb.grep(/\d/) -> $i, $j {
    $sum += $i + 3 * $j;
}
my $check = 10 - $sum % 10;
say $check;
