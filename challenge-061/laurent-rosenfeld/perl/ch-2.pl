use strict;
use warnings;
use feature qw /say/;

sub partition {
    my ($out, @in) = @_;
    for my $nb_digits (0..2) {
        return if $nb_digits > $#in;
        my $num = join "", @in[0..$nb_digits];
        return if $num > 255;
        return if $num =~ /^0\d/;
        my @left_digits = @in[$nb_digits+1..$#in];
        my $new_out = $out eq "" ? $num : ($out . ".$num");
        if (@left_digits == 0) {
            say $new_out if $new_out =~ /^\d+\.\d+\.\d+\.\d+$/;
            return;
        }
        partition ($new_out, @left_digits);
    }
}

my $in = shift // 25525511135;
my @digits = split //, $in;
partition "", @digits;
