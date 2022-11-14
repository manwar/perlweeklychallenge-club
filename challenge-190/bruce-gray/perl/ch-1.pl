use v5.36;

sub task1 ( $s ) {
    0+(    $s eq lc($s)
        or $s eq uc($s)
        or $s eq ucfirst lc($s)
    )
}


my @tests = (
    [ 'Perl'   , 1 ],
    [ 'TPF'    , 1 ],
    [ 'PyThon' , 0 ],
    [ 'raku'   , 1 ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ( $input, $expected ) = @{$_};

    is_deeply task1($input), $expected, "task1('$input')";
}
