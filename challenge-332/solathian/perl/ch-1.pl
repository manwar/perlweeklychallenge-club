use v5.40;
use List::Util qw(all);

binaryDate("2025-07-26");   # "11111101001-111-11010"
binaryDate("2000-02-02");   # "11111010000-10-10"
binaryDate("2024-12-31");   # "11111101000-1100-11111"

sub binaryDate($string) # it is assumed that the string is already of the correct format and is a valid date
{
    say join('-', map{sprintf("%b", $_)} split('-', $string));
}