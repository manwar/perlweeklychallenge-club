use strict;
use warnings;
use feature qw /say/;

my %nums = (0 => ['-'], 1 => ['_', ',', '@'], 2 => [qw <A B C>],
           3 => [qw <D E F>], 4 => [qw <G H I>], 5 => [qw <J K L>],
           6 => [qw <M N O>], 7 => [qw <A Q R S>],
           8 => [qw <T U V>], 9 => [qw <W X Y Z>]);

my $str = shift // "35";
take_one("", split //, $str);
say "";

sub take_one {
    my ($str, @digits) = @_;
    if (@digits == 0) {
        print "$str ";
        return;
    }
    my $digit = shift @digits;
    for my $letter (@{$nums{$digit}}) {
        my $new_str = $str . $letter;
        take_one($new_str, @digits)
    }
}
