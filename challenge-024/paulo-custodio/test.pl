#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Path::Tiny;
use Test::More;
use WWW::Mechanize;
use utf8::all;      # books are in UTF-8

# Challenge 024
# Task #1
# Create a smallest script in terms of size that on execution doesn't throw any
# error. The script doesn't have to do anything special. You could even come up
# with smallest one-liner.
#
# My solution: an empty file! (0 bytes) - Perl executes it and does not throw an error
is capture("perl perl/ch-1.pl"), "";

# Task #2
# Create a script to implement full text search functionality using Inverted
# Index. According to wikipedia:
#
# Download a couple of books from https://www.gutenberg.org/ebooks/
get_book('The Masque of the Red Death.txt',
         'https://www.gutenberg.org/files/1064/1064-0.txt');
get_book('The Fall of the House of Usher.txt',
         'https://www.gutenberg.org/cache/epub/932/pg932.txt');
get_book('The Cask of Amontillado.txt',
         'https://www.gutenberg.org/cache/epub/1063/pg1063.txt');
get_book('The Raven.txt',
         'https://www.gutenberg.org/cache/epub/17192/pg17192.txt');

# show index
is capture("perl perl/ch-2.pl search death"), <<END;
death  The Fall of the House of Usher.txt
death  The Masque of the Red Death.txt
death  The Raven.txt
END

is capture("perl perl/ch-2.pl search mystery"), <<END;
mystery  The Fall of the House of Usher.txt
mystery  The Raven.txt
END

is capture("perl perl/ch-2.pl search imagination"), <<END;
imagination  The Fall of the House of Usher.txt
imagination  The Raven.txt
END


unlink "index.db3",
       'The Masque of the Red Death.txt',
       'The Fall of the House of Usher.txt',
       'The Cask of Amontillado.txt',
       'The Raven.txt';
done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}

sub run {
    my($cmd) = @_;
    ok 0==system($cmd), $cmd;
}

sub get_book {
    my($file, $url) = @_;
    if (!-f $file) {
        say "Getting $url --> $file";
        my $mech = WWW::Mechanize->new();
        $mech->get($url);
        path($file)->spew($mech->content);

        # build index
        run("perl perl/ch-2.pl add '$file'");
    }
}
