use 5.036;

my $input_date = shift;

my ($y,$m,$d) = split '-', $input_date;
my $day_of_year = int((367*$m - 362) / 12) + $d
    - ($m <= 2 ? 0 : $y%4==0 && $y%100 || $y%400==0 ? 1 : 2);
say 'using calculation: ', $day_of_year;

use Time::Piece;
say 'using standard library: ', Time::Piece->strptime($input_date, '%F')->yday + 1;
