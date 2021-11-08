# sub invert_bit { $^m +^ (1 +< ($^n - 1)) }

sub invert_bit ( UInt:D $m, UInt:D $bit_to_invert ) {
    my $mask = 1 +< ($bit_to_invert - 1);
    return $m +^ $mask;
}
say invert_bit(12, 3);
say invert_bit(18, 4);
