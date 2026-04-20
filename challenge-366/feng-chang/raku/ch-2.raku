#!/bin/env raku

unit sub MAIN(Str:D $time where $time.match: /^ <[?0..9]> <[?0..9]> ':' <[?0..9]> <[?0..9]> $/);

my ($hour, $minute) = $time.split(':')».trans('?' => '.');
#put "hour $hour minute $minute";
#put (0..23)».fmt('%02d').grep({ .match(/^<$hour>$/) });
put (0..23)».fmt('%02d').grep(*.match(/^<$hour>$/)) * (0..59)».fmt('%02d').grep(*.match(/^<$minute>$/));
