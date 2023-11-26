#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @matrix;
    @matrix.push(| @args.map({ $_.split(q{ }).map({ $_.Int }) }) );
    @matrix = @matrix.map({ $_.reverse.map({ (!$_).Int }) });
    say q{(} ~ @matrix.map({ q{[} ~ $_.join(q{, }) ~ q{]} }).join(q{, }) ~ q{)};
}