# Test: perl6 ch-1.p6 2230120
use v6.d;

sub MAIN(Int $date) {
    say parse-date($date);
}

sub parse-date(Int $date) {
    # Regex to test date format
    return "Invalid date format"
        unless ($date ~~ /
            ^^            # Start of string
            (<[12]>)      # 1 or 2
            (\d\d)        # year 00-99
            (0<[1..9]> || # month 1-12
             1<[0..2]>)
            (0<[1..9]> || # day 1-31
             <[1..2]>\d||
             3<[01]>)
            $$            # End of string
        /);

    # The date string
    my $date_string =
        ( ($0 == 1) ?? '20' ~ $1  !! '19' ~ $1 )
        ~ '-' ~ $2 ~ '-' ~ $3;

    # Make sure the date is valid
    # even if it passed the format check
    try {
        my $date_check = Date.new($date_string);

        CATCH {
            return "Invalid date";
        }
    }

    return $date_string;
}
