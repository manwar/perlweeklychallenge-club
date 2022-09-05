use v6.d;
use Test;

sub hotter-days(IO() $input-file) {
    $input-file.lines».split(/\,\s*/).sort(*.[0]).rotor(2 => -1).grep({.[1][1] > .[0][1]}).map: *.[1][0]
}

'/tmp/temperature.txt'.IO.spurt: q:to/END/;
    2022-08-01, 20
    2022-08-09, 10
    2022-08-03, 19
    2022-08-06, 24
    2022-08-05, 22
    2022-08-10, 28
    2022-08-07, 20
    2022-08-04, 18
    2022-08-08, 21
    2022-08-02, 25
    END

my $desired-output = q:to/END/;
    2022-08-02
    2022-08-05
    2022-08-06
    2022-08-08
    2022-08-10
    END

plan 1;
is $desired-output.lines, hotter-days '/tmp/temperature.txt';
done-testing