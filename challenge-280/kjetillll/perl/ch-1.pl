use strict; use warnings; use Test::More tests=>3;

sub first_twice {
    my($str, %seen) = @_;
    $str =~ s/^.// ? $seen{$&}++ ? $& : first_twice($str, %seen) : undef
}

is first_twice( $$_{input} ) => $$_{output}
    for { input => "acbddbca", output => "d" },
        { input => "abccd",    output => "c" },
        { input => "abcdabbb", output => "a" }
