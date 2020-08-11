constant \SUNDAY = 7;

.say for
    ( 2019 .. 2100 )
    .map(  { DateTime.new( :$^year, month => 12, day => 25 ) })
    .grep( { .day-of-week == SUNDAY })
    .map(  { .year })
;

