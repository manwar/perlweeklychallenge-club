use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

sub largest_rectangle($matrix) {
    my $max = q();
    my $max_offset = length((split(/\R/, $matrix))[0]) - 1;
    for my $offset (0 .. $max_offset) {
        while ($matrix =~ m{^.{$offset}(1+).*\R(?=.{$offset}\1)}mg) {
            $max = $1 if length $max < length $1;
        }
    }

    return $max ? ($max . "\n") x 2 : 0;
}

use Test::More;

is largest_rectangle("1\n1\n"), "1\n1\n", 'Shortest rectangle possible';

is largest_rectangle(<<'EOF'
111
011
EOF
),
<<'EOF'
11
11
EOF
,
'Small square';

is largest_rectangle(<<'EOF'
11
11
EOF
),
"11\n11\n",
'All ones small';

is largest_rectangle(<<'EOF'
110
110
EOF
),
"11\n11\n",
'Beginning rectangle';

is largest_rectangle(<<'EOF'
01
10
EOF
),
0,
'None found';

is largest_rectangle(<<'EOF'
00
11
00
EOF
),
0,
'None found again';

is largest_rectangle(<<'EOF'
1011101
1111110
0011111
1101110
1111110
EOF
),
<<'EOF'
1111
1111
EOF
,
'Big square';

is largest_rectangle(<<'EOF'
101110
111100
001001
110111
110111
EOF
),
<<'EOF'
111
111
EOF
,
'Several lengths';

is largest_rectangle(<<'EOF'
000100
111000
001001
111110
111110
EOF
),
<<'EOF'
11111
11111
EOF
,
'Test case 1';

is largest_rectangle(<<'EOF'
101010
010101
101010
010101
EOF
),
0
,
'Test case 2';

is largest_rectangle(<<'EOF'
000111
111111
001001
001111
001111
EOF
),
<<'EOF'
1111
1111
EOF
,
'Test case 3';

is largest_rectangle(<<'EOF'
1011101
1111110
0011111
1101110
1101110
EOF
),
<<'EOF'
1111
1111
EOF
,
'Yet another test';

is largest_rectangle(<<'EOF'
110111
110111
EOF
),
<<'EOF'
111
111
EOF
,
'Biggest rectangle has offset';

done_testing;
