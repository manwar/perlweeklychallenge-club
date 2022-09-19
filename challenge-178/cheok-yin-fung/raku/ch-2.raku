# The Weekly Challenge 178
# Task 2 Business Date
use v6;

multi sub MAIN (Str $timestamp, Rat $duration-in-hours) {
    if    $timestamp ~~ /(\d\d\d\d)\-(\d\d)\-(\d\d)T(\d\d)\:(\d\d)/ 
          && $0 >= 1900 && $0 <= 2200
          && $1 >= 1 && $1 <= 12
          && $2 >= 1 && $2 <= Date.new("$0\-$1\-01").days-in-month
          && Date.new("$0\-$1\-$2").day-of-week <= 5
          && $3 >= 9 && $3 <= 17
          && $4 <= 59
    {
        say business-date($timestamp, $duration-in-hours).Str.substr(0,*-4);
    }
    else {
        say 'Valid timestamp format: YYYY-MM-DD"T"HH:MI';
        say "Business Hours: Mon-Fri, 9am-6pm"
    }
}

multi sub MAIN (Str $timestamp, Int $duration-in-hours) {
    MAIN($timestamp, $duration-in-hours.Rat);
}

multi sub MAIN () {
    return;
}

sub duration-to-w-d-h ($dur) {
    return Int($dur/45), Int(($dur % 45)/9), $dur % 9
}

sub business-date($t, $d) {
    my @wdh = duration-to-w-d-h($d);
    my $bd = DateTime.new($t~":00Z").later(weeks => @wdh[0]).later(days => @wdh[1]);
    if ($bd.day-of-week >= 6) {
        $bd = $bd.later(weeks => 1).later($bd.day-of-week - 5)
    }
    $bd = $bd.later(hours => @wdh[2]).later(minutes => @wdh[2] % 1 * 60);
    # from official doc > "[method earlier]
    # Unless the given unit is second or seconds, 
    # the given value will be converted to an Int."
    if ($bd.hour >= 18) {
        $bd = $bd.later(days => 1).earlier(hours => 9);
    }
    if ($bd.day-of-week == 6) {
        $bd = $bd.later(days => 2);
    }
    return $bd;
}




use Test;
is(business-date('2022-08-01T10:30', 4), 
    DateTime.new('2022-08-01T14:30:00Z').DateTime);
is(business-date('2022-08-01T17:00', 3.5), 
    DateTime.new('2022-08-02T11:30:00Z').DateTime);
is(business-date('2022-08-05T17:00', 3), 
    DateTime.new('2022-08-08T11:00:00Z').DateTime);
is(business-date('2022-08-01T09:00', 144.5), 
    DateTime.new('2022-08-23T09:30:00Z').DateTime);
plan 4;
done-testing;
