#!/usr/bin/raku

sub MAIN(
    Str $str,
    Str $char
) {
    my @positions = $str.indices($char);
    my $delete = @positions[*-1];

    for @positions -> $pos {
        my $next = $str.substr($pos + 1, 1);
        if  $next > $char {
            $delete = $pos;
            last;
        }
    }

    my $result = $str;
    $result.substr-rw($delete, 1) = q{};
    say $result;
}
