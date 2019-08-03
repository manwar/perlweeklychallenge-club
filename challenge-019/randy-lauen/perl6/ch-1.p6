#!/usr/bin/env perl6

=begin SYNOPSIS

Write a script to display months from the year 1900 to 2019 where you find 5 weekends
i.e. 5 Friday, 5 Saturday and 5 Sunday.

Usage:
    $ perl6 ch-1.p6 --from=YYYY --to=YYYY

Example output:
    $ perl6 ch-1.p6 --from=1900 --to=2019
    Found 119 months with 5 full weekends
    1901: Mar
    1902: Aug
    1903: May
    1904: Jan, Jul
    ...
    2017: Dec
    2019: Mar
    
=end SYNOPSIS

role MonthRole {
    method has-five-full-weekends {
        # The month must have 31 days.
        return False unless self.days-in-month == 31;
        # The month must begin on a Friday.
        my $date = self.day == 1 ?? self !! Date.new( self.year, self.month, 1 );
        return $date.day-of-week == 5;
    }

    method month-name-short {
        given self.month {
            when  1 { 'Jan' }
            when  2 { 'Feb' }
            when  3 { 'Mar' }
            when  4 { 'Apr' }
            when  5 { 'May' }
            when  6 { 'Jun' }
            when  7 { 'Jul' }
            when  8 { 'Aug' }
            when  9 { 'Sep' }
            when 10 { 'Oct' }
            when 11 { 'Nov' }
            when 12 { 'Dec' }
        }
    }
}

sub find-months( $from, $to ) {
    my @matches;
    for $from .. $to -> $year {
        for 1 .. 12 -> $month {
            my $date = Date.new($year,$month,1) but MonthRole;
            push @matches, $date if $date.has-five-full-weekends;
        }
    }
    return @matches;
}

sub MAIN( :$from!, :$to! ) {
    my @matches = find-months( $from, $to );
    say "Found @matches.elems() months with 5 full weekends";
    for @matches.classify( { .year } ).pairs.sort({ .key }) -> $pair {
        say "{$pair.key}: { $pair.value>>.month-name-short.join(', ') }";
    }
}


