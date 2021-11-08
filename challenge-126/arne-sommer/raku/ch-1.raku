#! /usr/bin/env raku

say (2 .. @*ARGS[0]).grep( * !~~ /1/ ).eager.elems;
