#! /usr/bin/perl6

my $foo="wibble";

say sprintf('0x%x',$foo.WHERE);

# Please note that in the Rakudo implementation of Raku, and possibly other implementations, the memory location of an object is NOT fixed for the lifetime of the object. So it has limited use for applications, and is intended as a debugging tool only. -- https://docs.raku.org/routine/WHERE
