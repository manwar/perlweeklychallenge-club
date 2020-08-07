#!/usr/bin/perl6

sub MAIN(
    $A,     #= start line
    $B,     #= end line
    $file   #= file name
    where { $A > 0 && $A <= $B}
) {
    .say for $file.IO.lines[$A - 1 .. $B - 1];
}