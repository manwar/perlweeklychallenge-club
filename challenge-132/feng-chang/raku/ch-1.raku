#!/bin/env raku

my method dstr(Date:D $dt: --> Str:D) {
    $dt.Str.trans('-' => '/')
}

sub MAIN(Str:D $birth-date-str) {
    my Date \birth-date = $birth-date-str.trans('/' => '-').Date;
    my UInt \age = now.Date - birth-date;
    put "{ (birth-date - age).&dstr }, { (now.Date + age).&dstr }";
}
