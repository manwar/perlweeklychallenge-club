#!/usr/bin/env raku
# vim: ft=raku sw=4 expandtab
use v6.d;
use Lingua::EN::Numbers :short;

my $sot = 51;
my @out;
my @data =
        [ '1', '2' ],  [ '1234567890', '1234567890' ],
        [ '12', '34' ],  [ '123456789', '012345678' ],
        [ '123', '456' ],  [ '12345678', '90123456' ],
        [ '1234', '5678' ],  [ '1234567', '8901234' ],
        [ '12345', '67890' ],  [ '123456', '789012' ],
        [ '1234567890' x 2, '1234567890' x 2 ],
        [ '1234567890' x 3, '1234567890' x 3 ],
        [ '1234567890' x 6, '1234567890' x 6 ],
;

my @input = @data.pick;
my ($a, $b) = @input[0];
die 'Mismatched input' unless $a.chars == $b.chars;
@out.push: $a, $b;

my @f-word = $a, $b, {
    state $x =$a;
    state $y =$b;
    my $z= $x ~ $y;
    ($x,$y)=($y,$z); 
    $z} … ∞;

my $f-word;
my $words;
for @f-word {
    $f-word = $_;
    $words ~= "'$_'\n";
    last if .chars ≥ $sot;
}

@out.push: $f-word.substr( $sot-1, 1), $words, (' ' x 9), ord-d( $sot), $sot;
@out.push: $f-word,$f-word.substr( $sot -1 ,1) ;

printf qq{Input:  \$a = '%s', \$b = '%s'}
     ~ "\nOutput: %s \n\nFibonacci Words:\n\n%s\n%sThe   %s"
     ~ "  digit   in  the  first   term  having   at  least  %s  digits\n"
     ~ qq{'%s' is %s.\n},
     |@out;
