#!/usr/bin/raku

sub MAIN(
    $num,
    $base
) {
     Int.^lookup('base').wrap(-> |args {
        my ($number, $base) = args».Str;
        my $return;

        if $base !~~ 2 .. 64 {
            die "base $base is out of range";
        }

        if $base <= 36 {
            $return = callsame;
        } elsif $number == 0 {
                $return = '0';
        } else {
            my @digits = ([0 ..9], ['A' .. 'Z'], ['a' .. 'z'], ['+', '/']).flat;
            @digits = @digits[0 ..^ $base];
            my @result;
            while $number > 0 {
                my $digit = ($number % $base).Int;
                @result.unshift(@digits[$digit]);
                $number = ($number / $base).Int;
            }

            $return = @result.join(q{});
        }

        $return;
    });

    $num.base($base).say;
}
