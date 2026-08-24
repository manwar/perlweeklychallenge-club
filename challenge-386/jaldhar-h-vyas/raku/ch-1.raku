#!/usr/bin/raku

sub MAIN(
    Str $num,
    Int $base
) {
    Str.^lookup('parse-base').wrap(-> |args {
        my ($number, $base) = args».Str;
        my $return;

        if $base !~~ 2 .. 64 {
            die "base $base is out of range";
        }

        if $number == 0 {
            $return = '0';
        } elsif $base > 36 {
            my $magnitude = $number.chars - 1;
            my %digits =
                ([0 ..9], ['A' .. 'Z'], ['a' .. 'z'], ['+', '/']).flat
                Z=>
                (0 ..^ $base);

            for $number.comb -> $digit {
                my $base10 = %digits{$digit} // 
                    die "malformed base-$base number\n";
                $return += $base10 * $base ** $magnitude;
                $magnitude--;
            }
        } else {
            $return = callsame;
        }

        $return;
    });

    $num.parse-base($base).say;
}