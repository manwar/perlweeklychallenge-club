use strict;
use warnings;
use feature "say";

sub sedol {
    my $in = shift;
    return 0 if $in  =~ /[AEIOU]/i;  # Vowels not allowed
    return 0 unless $in =~ /^[A-Z0-9]{6}[0-9]$/; # 6 alphanumericals + 1 digit
    my ($sedol, $check) = (substr($in, 0, 6), substr($in, 6, 1));
    my %values;
    my $count = 0;
    for my $val ( 0..9, 'A'..'Z') {
        $values{$val} = $count++;
    }
    my @weights = (1, 3, 1, 7, 3, 9);
    my $sum = 0;
    my @chars = split //, $sedol;
    for my $i (0..5) {
        $sum += $values{$chars[$i]} * $weights[$i];
    }
    my $check_digit = (10 - $sum % 10) % 10;
    return 1 if $check_digit == $check;
    0
}
for my $s (qw<456765 65AR345 2936921 1234567 B0YBKL9>) {
    say "$s: ", sedol($s);
}
