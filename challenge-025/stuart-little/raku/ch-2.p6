#!/usr/bin/env perl6
use v6;

use HTTP::Tiny;
use JSON::Fast;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Str $text is copy,
    Str :a1(:$alphabet1) = 'XLEMFHIWOVNYRUDQCJPASGBTKZ',
    Str :a2(:$alphabet2) = 'SGLBIZHJMFTRXAVKNQPDWYCUOE',
    Bool :e(:$encode),
    Bool :d(:$decode),
) {
    my $URL=qq{https://www.dcode.fr/api/};
    my %data=(
	tool => 'chao-cipher',	
	alphabet1 => $alphabet1,
	alphabet2 => $alphabet2,
    );

    $text ~~ s:g/\s+/+/;
    ($decode) ?? (%data.<ciphertext> = $text) !! (%data.<plaintext> = $text);

    say .<content>.decode.&from-json.<results> with HTTP::Tiny.new(agent => 'HTTP-Tiny').post: $URL, content => %data;
}





