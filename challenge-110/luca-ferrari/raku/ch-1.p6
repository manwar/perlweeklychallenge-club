#!raku


sub MAIN( Str $file-name = 'phone.txt' ) {
    my $phone-regexp  = rx/ \d ** 10 /;
    my $prefix-regexp = rx/
             <[+]> \d ** 2
             || <[(]> \d ** 2 <[)]>
             || \d ** 4
    /;


    my $phone-rx = rx / ^ \s* $prefix-regexp \s+ $phone-regexp $ /;

    $_.say if $_ ~~ $phone-rx for $file-name.IO.lines;
}
