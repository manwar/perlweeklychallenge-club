#!/usr/bin/env raku

use DateTime::Format;
use Time::Piece:from<Perl5>;
use Test;
plan 10;

is fun-time("00:45"), "12:45 AM";
is fun-time("01:45"), "01:45 AM";
is fun-time("03:15"), "03:15 AM";
is fun-time("13:45"), "01:45 PM";
is fun-time("18:45"), "06:45 PM";

is fun-time("12:45 AM"), "00:45";
is fun-time("01:45 AM"), "01:45";
is fun-time("03:15 AM"), "03:15";
is fun-time("01:45 PM"), "13:45";
is fun-time("06:45 PM"), "18:45";

multi fun-time($T) 
{
    strftime("%I:%M %p", DateTime.new("1970-01-01T$T:00Z"));
}

multi fun-time($T where .ends-with("am"|"pm", :i)) 
{
    Time::Piece.strptime($T, "%r").strftime("%R");
}
