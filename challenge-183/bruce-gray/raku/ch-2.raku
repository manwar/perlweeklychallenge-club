# I would have used .polymod(365), but it won't account for leap years
sub date-difference ( Str $s1, Str $s2 --> Str ) {
    my Date ( $d1, $d2 ) = ($s1, $s2).sort.map({ Date.new: $_ });

    my $later-in-year = [lt] map *.Str.substr(4), $d2, $d1;

    my $years = $d2.year - $d1.year - (1 if $later-in-year);

    my $days = $d2 - $d1.later( :$years );

    return join ' ',
        ( ( "$years year" ~ ('s' if $years > 1) ) if $years ),
        ( (  "$days day"  ~ ('s' if $days  > 1) ) if $days  ),
    ;
}


my @tests =
    ( ( '2019-02-10', '2022-11-01' ), '3 years 264 days' ),
    ( ( '2020-09-15', '2022-03-29' ), '1 year 195 days'  ),
    ( ( '2019-12-31', '2020-01-01' ), '1 day'            ),
    ( ( '2019-12-01', '2019-12-31' ), '30 days'          ),
    ( ( '2019-12-31', '2020-12-31' ), '1 year'           ),
    ( ( '2019-12-31', '2021-12-31' ), '2 years'          ),
    ( ( '2020-09-15', '2021-09-16' ), '1 year 1 day'     ),
    ( ( '2019-09-15', '2021-09-16' ), '2 years 1 day'    ),

    # 2020 was a leap year
    ( ( '2018-02-28', '2019-02-28' ), '1 year'           ),
    ( ( '2019-02-28', '2020-02-28' ), '1 year'           ),
    ( ( '2020-02-28', '2021-02-28' ), '1 year'           ),
    ( ( '2021-02-28', '2022-02-28' ), '1 year'           ),

    ( ( '2018-02-28', '2019-03-01' ), '1 year 1 day'     ),
    ( ( '2019-02-28', '2020-03-01' ), '1 year 2 days'    ),
    ( ( '2020-02-28', '2021-03-01' ), '1 year 1 day'     ),
    ( ( '2021-02-28', '2022-03-01' ), '1 year 1 day'     ),

    ( ( '1800-01-01', '1900-01-01' ), '100 years'        ),
    
;
use Test;
plan +@tests;
for @tests -> ( ($s1, $s2), $exp ) {
    is date-difference($s1, $s2), $exp;
}
