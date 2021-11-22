#!/usr/bin/env raku

# DCB = Decimal Coded Binary
subset DCB of UInt where /^ <[01]>+ $/; 

sub infix:<b+>(DCB \a, DCB \b) 
{
    (a.Str.parse-base(2) + b.Str.parse-base(2)).base(2);
}

say 11  b+ 1;
say 101 b+ 1;
say 100 b+ 11;
