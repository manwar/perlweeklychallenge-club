#! /usr/bin/raku

sub longestabsolutepath($fs) {
    my @components;
    my $maxlen = 0;
    for $fs.split("\\n") -> $entry {
        my @parts = $entry.split("\\t");
        my $depth = @parts.elems;
        while (@components.elems < $depth) {
            @components.push(0);
        }
        while (@components.elems >= $depth) {
            @components.pop;
        }
        @components.push(@parts[*-1].chars);
        with @parts[*-1].index('.') {
            $maxlen = max($maxlen, @components.sum + @components.elems - 1);
        }
    }
    $maxlen;
}

use Test;

plan 5;

is(longestabsolutepath('dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2'), 0, 'example 1');
is(longestabsolutepath('file1.txt\nfile2.ext\na.png'), 9, 'example 2');
is(longestabsolutepath('my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png'), 38, 'example 3');
is(longestabsolutepath('root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt'), 14, 'example 4');
is(longestabsolutepath('a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt'), 32, 'example 5');
