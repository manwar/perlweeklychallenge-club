#!/usr/bin/raku

constant ALGORITHM = 1;

say "\n<<Using algorithm {ALGORITHM}>>\n";

sub largest-rectangle($matrix) {
    my $res = ALGORITHM == 1 ?? largest-rectangle-v1 $matrix !! largest-rectangle-v2 $matrix;

    $res > 0 ?? "{1 x $res}\n" x 2 !! 0
}

# Solution using regex and loops
sub largest-rectangle-v1($matrix) {
    my $max = 0;
    my $max-offset = $matrix.split(/\s+/).head.chars.pred;
    for 0 .. $max-offset -> $offset {
        my $ones = '';
        for $matrix ~~ m:g/^^ \d**{$offset} (1+) {$ones=$0} (\d*\s+) <?before \d**{$offset} $ones> / {
            $max = $_[0].chars if $max < $_[0].chars
        }
    }
    $max
}

# Solution using a single regex a no loops
sub largest-rectangle-v2($matrix) {
    my ($pos, $len-pref, $len-ones) = 0, 0, 0;
    $matrix ~~ m:g{
        (\d*?)    { $len-pref = $0.chars; make 0 }    # capture discarded prefix & store its length, initialize result
        [  \s+    { $pos = 0 }                        # We reach end of line, reset pos for the next one
        || (1+)   { $len-ones = $1.chars }            # capture sequence of ones, store its length
           <?before                                   # must be followed by:
               \d* \s+                                # rest of line (rest of numbers + new line)
               \d**{$len-pref + $pos} 1**{$len-ones}  # next line: same structure as previous line
           >
           { $pos += $len-pref + $len-ones }          # update processed position of the current line
           { make +$len-ones }                        # prepare result
        ]
    } andthen .map(*.made).max                        # get largest match
}

use Test;

is largest-rectangle("1\n1\n"), "1\n1\n", 'Shortest rectangle possible';

is largest-rectangle(q:to/END/
111
011
END
),
q:to/END/
11
11
END
,
'Small square';

is largest-rectangle(q:to/END/
11
11
END
),
"11\n11\n",
'All ones small';

is largest-rectangle(q:to/END/
110
110
END
),
"11\n11\n",
'Beginning rectangle';

is largest-rectangle(q:to/END/
01
10
END
),
0,
'None found';

is largest-rectangle(q:to/END/
00
11
00
END
),
0,
'None found again';

is largest-rectangle(q:to/END/
1011101
1111110
0011111
1101110
1111110
END
),
q:to/END/
1111
1111
END
,
'Big square';

is largest-rectangle(q:to/END/
101110
111100
001001
110111
110111
END
),
q:to/END/
111
111
END
,
'Several lengths';

is largest-rectangle(q:to/END/
000100
111000
001001
111110
111110
END
),
q:to/END/
11111
11111
END
,
'Test case 1';

is largest-rectangle(q:to/END/
101010
010101
101010
010101
END
),
0
,
'Test case 2';

is largest-rectangle(q:to/END/
000111
111111
001001
001111
001111
END
),
q:to/END/
1111
1111
END
,
'Test case 3';

is largest-rectangle(q:to/END/
1011101
1111110
0011111
1101110
1101110
END
),
q:to/END/
1111
1111
END
,
'Yet another test';

is largest-rectangle(q:to/END/
110111
110111
END
),
q:to/END/
111
111
END
,
'Biggest rectangle has offset';
