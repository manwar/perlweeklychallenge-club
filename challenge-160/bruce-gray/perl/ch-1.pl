use Modern::Perl;
use experimental qw<signatures>;

sub magic_four ( $n ) {
    die unless $n =~ /^[0-9]$/;
    my @w = qw<zero one two three four five six seven eight nine>;

    my @s = ($w[$n]);
    push @s, $w[ length $s[-1] ] while $s[-1] ne 'four';
    push @s, 'magic';

    my @t = map { $s[$_ - 1] . ' is ' . $s[$_] } 1 .. $#s;
    
    return ucfirst(join(", ", @t)) . '.';
}

my @tests = (
    [ 5,                              'Five is four, four is magic.' ],
    [ 7,               'Seven is five, five is four, four is magic.' ],
    [ 6, 'Six is three, three is five, five is four, four is magic.' ],
    [ 1, 'One is three, three is five, five is four, four is magic.' ],
    [ 2, 'Two is three, three is five, five is four, four is magic.' ],
    [ 3,               'Three is five, five is four, four is magic.' ],
    [ 4,                                            'Four is magic.' ],
    [ 8,               'Eight is five, five is four, four is magic.' ],
    [ 9,                              'Nine is four, four is magic.' ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ($in, $expected) = @{$_};
    is magic_four($in), $expected, "magic_four($in)";
}
