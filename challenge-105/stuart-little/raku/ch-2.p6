#!/usr/bin/env perl6
use v6;

# run <script> <name>

sub ellis($c,$name) {
    qq|{$c}o-| ~ (($c eq $name.substr(0,1).lc) ?? ($name.substr(1)) !! ($c ~ $name.substr(1)));
}

sub verse(Str $name) {
    my $main = tc($name);
    qq:to/END/;
$main, $main, {ellis('b',$main)}
Bonana-fanna {ellis('f',$main)}
Fee fi {ellis('m',$main)}
$main!    
END
}

say verse(@*ARGS[0]);
