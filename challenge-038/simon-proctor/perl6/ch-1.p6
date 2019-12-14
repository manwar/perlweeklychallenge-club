#!/usr/bin/env perl6

constant $DATE-MATCH = rx/^ $<century>=(<[12]>) $<year>=(<[0..9]>**2) $<month>=("01"|"02"|"03"|"04"|"05"|"06"|"07"|"08"|"09"|"10"|"11"|"12") $<day>=(<[0..3]><[0..9]>) $/;

subset PossData of Str where * ~~ $DATE-MATCH;

multi sub MAIN($s) is hidden-from-USAGE {
    say "{$s} doesn't match the valid string condition\n$*USAGE";
}

#| Parse the data string format
multi sub MAIN(
    PossData $date #= Date in the format (1/2 2000/1900), year, month, day 
) {
    my $match = ( $date ~~ $DATE-MATCH );
    my $result;
    {
        $result = Date.new( :year( $match.<year> + ( $match.<century> ~~ 1 ?? 2000 !! 1900 ) ), :month( $match<month> ), :day( $match<day> ) );  
        CATCH {
            default {
                say "{$date} is not a valid date\n$*USAGE";
                exit;
            }
        }
    }
    say $result;
}
