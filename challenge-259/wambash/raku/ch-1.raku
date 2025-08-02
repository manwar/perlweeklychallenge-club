#!/usr/bin/env raku

sub banking-day-offset (Date() $start-day,+bank-holidays,:$offset) {
   $start-day, *.later(:1day) ... *
   andthen .grep: *.day-of-week != 6|7
   andthen .grep: { $_ ∉ bank-holidays }\
   andthen .skip: $offset
   andthen .head
}

multi MAIN (Bool :test($)!) {
    use Test;
    is banking-day-offset('2018-06-28'.Date, <2018-07-03>».Date):3offset, '2018-07-04'.Date;
    is banking-day-offset('2018-06-28'.Date, ):3offset, '2018-07-03'.Date;
    done-testing;
}

multi MAIN ($start-day,+bank-holidays,:$offset) {
    say banking-day-offset $start-day, bank-holidays».Date,:$offset
}
