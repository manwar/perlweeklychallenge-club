use v6;

# AUTHOR: Robert DiCicco
# DATE: 26-APR-2022
# Challenge 162 ISBN-13 ( Raku )

sub makeCheckDigit ( $n) {
  my @arr = $n.comb;
  my $evensum = @arr[0] + @arr[2] + @arr[4] + @arr[6] + @arr[8] + @arr[10];
  my $oddsum = (@arr[1] + @arr[3] + @arr[5] + @arr[7] + @arr[9] + @arr[11]) * 3;
  my $presum = ($evensum + $oddsum) % 10;
  my $checkdigit = 10 - $presum;

  return $checkdigit;
}

my $isbn = '978-0-306-40615-7';
my $num = substr($isbn,0,15);
$num ~~ tr/-//;
my $checkdigit = makeCheckDigit($num);

say "ISBN-13 check digit for $isbn is $checkdigit.";
