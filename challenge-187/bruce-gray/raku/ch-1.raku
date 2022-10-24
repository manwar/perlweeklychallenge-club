
# Not needed (could use Set), but more efficient this way, and these lines are reusable
multi sub infix:<∩> ( Range \a, Range \b --> Range ) { (a,b)».min.max .. (a,b)».max.min }
multi sub infix:<∪> ( Range \a, Range \b --> Range ) { (a,b)».min.min .. (a,b)».max.max }

sub task1 ( @itineraries ) {
    sub offset ( Str $s --> Date ) {
        $s ~~ / ^ (\d\d) '-' (\d\d) $ /
            orelse die;

        return Date.new(2001, +$1, +$0)
    }

    my Range @z = @itineraries.map: -> ($s, $e) {
        Range.new( |map &offset, ($s, $e) );
    }

    return elems [∩] @z;
}

sub get_tests ( ) {
    my $test_data = q:to/END/;
        Example 1

        Input: Foo => SD: '12-01' ED: '20-01'
               Bar => SD: '15-01' ED: '18-01'

        Output: 4 days

        Example 2

        Input: Foo => SD: '02-03' ED: '12-03'
               Bar => SD: '13-03' ED: '14-03'

        Output: 0 day

        Example 3

        Input: Foo => SD: '02-03' ED: '12-03'
               Bar => SD: '11-03' ED: '15-03'

        Output: 2 days

        Example 4

        Input: Foo => SD: '30-03' ED: '05-04'
               Bar => SD: '28-03' ED: '02-04'

        Output: 4 days


        Extra 1

        Input: Foo => SD: '30-03' ED: '05-04'

        Output: 7 days

        Extra 2

        Input: Foo => SD: '30-03' ED: '05-04'
               Bar => SD: '28-03' ED: '02-04'
               Baz => SD: '01-04' ED: '02-04'

        Output: 2 days

        END
    my regex dashedDate { \d\d \- \d\d }
    my regex input      { \w+ \s* '=>' \s* 'SD:' \s* \'(<dashedDate>)\'
                                       \s* 'ED:' \s* \'(<dashedDate>)\' }
    my $re = /
        \s* $<name>=[[Example|Extra] \s+ \d+]
        \s* 'Input:'  \s* <input>+ % \s+
        \s* 'Output:' \s* $<expected>=[\d+] \s* days?
    /;

    my @tests = $test_data.match(:g, $re);

    my @r;
    for @tests -> Match $test {
        my @starts_and_ends = gather for $test.<input>.list -> Match $i {
            take $i.map(~*.<dashedDate>).cache;
        }
        push @r, {
            name     => "$test.<name>: @starts_and_ends[]",
            expected => +$test.<expected>,
            in       => @starts_and_ends,
        };
    }
    return @r;
}
use Test;
my @tests = get_tests();
plan +@tests;
for @tests -> %t {
    is task1(%t<in>), %t<expected>, %t<name>;
}
