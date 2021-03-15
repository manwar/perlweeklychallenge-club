#!/usr/bin/perl
use warnings;
use strict;
use utf8;

=head1 098/1

This is very unusual. What should happen if we refer to the same file
in a different way, e.g. C<file.txt> versus C<./file.txt>? Creating an
object for each file would have made more sense.

=cut

{   my %fh;
    sub readN {
        my ($file, $chars) = @_;
        unless (exists $fh{$file}) {
            open $fh{$file}, '<:encoding(UTF-8)', $file;
        }
        read $fh{$file}, my ($buffer), $chars;
        return $buffer
    }
}

use Test::More tests => 6;

{   my $FILE = 'input.txt';
    open my $out, '>', $FILE or die $!;
    print {$out} '1234567890';
    close $out;

    is readN($FILE, 4), '1234';
    is readN($FILE, 4), '5678';
    is readN($FILE, 4), '90';

    unlink $FILE;
}
{   my $FILE = 'utf8.txt';
    open my $out, '>:encoding(UTF-8)', $FILE or die $!;
    print {$out} 'žluťoučký kůň';
    close $out;

    is readN($FILE,  1), 'ž', 'utf-8';
    is readN($FILE, 12), 'luťoučký kůň', 'utf-8';
    is readN($FILE,  1), "", 'eof';
    unlink $FILE;
}
