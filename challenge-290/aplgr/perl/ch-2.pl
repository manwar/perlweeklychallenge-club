use strict;
use warnings;

sub luhn_check {
    my ($str) = @_;
    $str =~ s/[^0-9]//g;

    my $payload = substr($str, -1);
    my $sum = 0;
    my $length = length($str);

    for (my $i = 0; $i < $length - 1; $i++) {
        my $digit = substr($str, $length - 2 - $i, 1);
        if ($i % 2 == 0) {
            $digit *= 2;
            $digit -= 9 if $digit > 9;
        }
        $sum += $digit;
    }

    my $check_digit = (10 - ($sum % 10)) % 10;

    return $payload == $check_digit ? 1 : 0;
}

1;