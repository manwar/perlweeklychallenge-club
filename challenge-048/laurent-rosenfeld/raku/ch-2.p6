use v6;

for 2000 .. 2300 -> $year {
    my ($month, $day) = ($year.flip ~~ /(\d\d)(\d\d)/)[0, 1];
    next if $month > 12 or $month < 1 or $day > 31 or $day < 1;
    say "$month/$day/$year is a palindromic date.";
}
