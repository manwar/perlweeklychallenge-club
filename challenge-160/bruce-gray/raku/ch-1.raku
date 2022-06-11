sub magic_four ( UInt $n where ^10 ) {
    constant @w = <zero one two three four five six seven eight nine>;

    my @s = @w[$n], { @w[.chars] } ... 'four';  # e.g. <seven five four>
    push @s, 'magic';                           # e.g. <seven five four magic>
    
    my @s21 = @s.rotor(2 => -1);    # e.g. <seven five>, <five four>, <four magic>
    my @is  = @s21».join: ' is ';   # e.g. 'seven is five', 'five is four', 'four is magic'

    return @is.join(', ').tc ~ '.';
}

my @tests =
    5 =>                              'Five is four, four is magic.',
    7 =>               'Seven is five, five is four, four is magic.',
    6 => 'Six is three, three is five, five is four, four is magic.',
    
    1 => 'One is three, three is five, five is four, four is magic.',
    2 => 'Two is three, three is five, five is four, four is magic.',
    3 =>               'Three is five, five is four, four is magic.',
    4 =>                                            'Four is magic.',
    8 =>               'Eight is five, five is four, four is magic.',
    9 =>                              'Nine is four, four is magic.',
;
use Test;
plan +@tests;
for @tests {
    my ($in, $expected) = .kv;
    is magic_four($in), $expected, "magic_four($in) eq '$expected'";
}
