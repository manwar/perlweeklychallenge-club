#!/usr/bin/env perl

=head1 SYNOPSIS

To test C<ch-2.pl>, do the following:
* Download the Canterbury corpus at http://www.corpus.canterbury.ac.nz/descriptions/.
* Extract it to a directory.
* Run this script with that directory as an argument.

Example output:

    $ perl test-lzw.pl cantrbry/
    +--------------+---------+------------+-------+
    | File         | Size    | Compressed | Ratio |
    +--------------+---------+------------+-------+
    | alice29.txt  | 152089  | 70226      | 46.2% |
    | asyoulik.txt | 125179  | 62748      | 50.1% |
    | cp.html      | 24603   | 14948      | 60.8% |
    | fields.c     | 11150   | 7084       | 63.5% |
    | grammar.lsp  | 3721    | 2818       | 75.7% |
    | kennedy.xls  | 1029744 | 365572     | 35.5% |
    | lcet10.txt   | 426754  | 184752     | 43.3% |
    | plrabn12.txt | 481861  | 218914     | 45.4% |
    | ptt5         | 513216  | 70242      | 13.7% |
    | sum          | 38240   | 25054      | 65.5% |
    | xargs.1      | 4227    | 3584       | 84.8% |
    +--------------+---------+------------+-------+

=cut

use strict;
use warnings;
use feature 'say';

use Carp::Assert;
use Path::Tiny;
use File::Compare ();
use Text::Table::Tiny ();

my $dir = $ARGV[0] // '';
die "'$dir' must be readable directory\n" unless -r -d $dir;

my @rows = ( [ 'File', 'Size', 'Compressed', 'Ratio' ] );

for my $file ( sort( path($dir)->children() ) ) {
    my $basename = $file->basename;
    my $encoded_file = "/tmp/$basename.encoded";
    my $decoded_file = "/tmp/$basename.decoded";

    system("perl ./ch-2.pl --encode $file > $encoded_file") == 0
        or die "encoding failed: $?";

    system("perl ./ch-2.pl --decode $encoded_file > $decoded_file") == 0
        or die "decoding failed: $?";

    if ( File::Compare::compare( $file, $decoded_file ) == 0 ) {
        push @rows, [
            $basename,
            -s $file,
            -s $encoded_file,
            sprintf( "%.1f%%", 100 * ( (-s $encoded_file) / (-s $file) ) )
        ],
    }
    else {
        die "Files differ: $file, $decoded_file";
    }
}

say Text::Table::Tiny::generate_table( rows => \@rows, header_row => 1 );

exit 0;


