#!/usr/bin/env raku

sub challenge(Str \t) returns Str {
    t~~/(\d+)\:(\d+)\s?([a|p]m)?/;my (\h,\m,\q)=$/[*];sprintf('%02d:%02d%s',q??h==12??q eq'am'??0!!h!!h+(12*(q eq'pm'))!!h==0|12??12!!h%12,m,q??''!!h>=12??'pm'!!'am');
}

# Only used to describe the above in my blog :)
sub challenge-expanded(Str \t) returns Str {
    t ~~ /
      (\d+)     # One or more digits (should technically use \d ** {2}, but this is shorter
      \:        # A literal colon character
      (\d+)     # One or more digits (again, should use \d ** {2})
      \s?       # An optional space (to support HH:MMam or HH:MM am)
      ([a|p]m)? # An optional 'am' or 'pm' (to support both 12- and 24-hour time)
    /;

    my (\h, \m, \q) = $/[*];

    # The logic in here is the same as above, with added parentheses for clarity
    sprintf(
      '%02d:%02d%s',
      q ??
        (h == 12 ??
          (q  eq 'am' ?? 0 !! h) !!
          h + (12 * ( q eq 'pm'))) !!
        h == 0|12 ?? 12 !! h%12,
      m,
      q ?? '' !! (h >= 12 ?? 'pm' !! 'am')
    );
}

multi sub MAIN(Str $time) {
    say challenge($time);
}

multi sub MAIN(Bool :$test, Bool :$verbose = False) {
    use Test;

    my @tests = (
        # Provided
        ('05:15pm' , '17:15'),
        ('05:15 pm', '17:15'),
        ('19:15'   , '07:15pm'),
        # Edge cases
        ('00:00'  , '12:00am'),
        ('12:00am', '00:00'),
        ('12:00'  , '12:00pm'),
        ('12:00pm', '12:00')
    );

    for @tests -> ($input, $expected) {
        is(challenge($input), $expected);
        # Confirm the expanded version works the same way
        is(challenge-expanded($input), $expected);
    }

    # If verbose, check that challenge(challenge($t)) == $t for all possible $t
    if $verbose {
        for (1..12) X (^59) X ('am', 'pm') -> ($hour, $minute, $qualifier) {
            my $time = sprintf('%02d:%02d%s', $hour, $minute, $qualifier);
            my $converted = challenge($time);
            is(challenge($converted), $time);
        }
    }

    done-testing;
}
