sub sedol( Str $in ) {
    return 0 if $in  ~~ /<[AEIOU]>/;  # Vowels not allowed
    return 0 unless $in ~~ /^ <[0..9B..Z]>**6 <[0..9]> $/; # 6 alphanumericals + 1 digit
    my ($sedol, $check) = substr($in, 0, 6), substr($in, 6, 1);
    my %values;
    my $count = 0;
    for ( 0..9, 'A'..'Z').flat -> $val {
        %values{$val} = $count++;
    }
    my @weights = 1, 3, 1, 7, 3, 9;
    my $sum = [+] @weights Z* map {%values{$_}}, $sedol.comb;
    my $check_digit = (10 - $sum % 10) % 10;
    return 1 if $check_digit == $check;
    0
}
for <456765 65AR345 2936921 1234567 B0YBKL9> -> $s {
    say "$s: ", sedol($s);
}
