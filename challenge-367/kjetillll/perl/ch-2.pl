use strict; use warnings; use feature 'signatures'; no warnings 'experimental::signatures'; no warnings 'recursion';
my($true, $false) = (1, 0);

sub overlap {
    my %minute_already_taken;
    $minute_already_taken{$_}++ and return $true
        for
        event_minutes( @_[0, 1] ),
        event_minutes( @_[2, 3] );
    return $false
}

sub event_minutes ($start, $end) {
    $start eq $end ? () : ( $start, event_minutes( next_minute( $start ), $end) )
}

sub next_minute {
    my($hh, $mm) = shift() =~ /(\d\d):(\d\d)/;
    ++$mm;
    $mm =~ s/60/00/ and ++$hh and $hh =~ s/24/00/;
    "$hh:$mm"
}

print pop(@$_) == overlap( @$_ ) ? "ok\n" : "ERROR\n" for
[ "10:00", "12:00",
  "11:00", "13:00"  => $true  ],
[ "09:00", "10:30",
  "10:30", "12:00"  => $false ],
[ "14:00", "15:30",
  "14:30", "16:00"  => $true  ],
[ "08:00", "09:00",
  "09:01", "10:00"  => $false ],
[ "23:30", "00:30",
  "00:00", "01:00"  => $true  ],

    
# An unnecessary slow and memory consuming algorithm, but it handles the
# midnight problem in a clearer way than the alternatives I could think of.
