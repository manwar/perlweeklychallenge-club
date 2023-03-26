# Thanks to e-choroba & james-smith & mark-anderson for
# unknowingly providing the tests cases I needed to exercise the multi-pass merging.
# I scanned the repo for such bonus tests, but have not looked at their coded solutions.

sub transative_closures ( @groups_input ) {
    my @groups = @groups_input;

    # I am sure this could be greatly simplified,
    # and also made faster for large numbers of merges,
    # but I am out of time for this week.

    loop {
        my $unmodified = True;
        my @transative_closures;
        for @groups -> SetHash $g {
            with @transative_closures.first( :k, { $_ ∩ $g } ) -> $k {
                @transative_closures[$k] ∪= $g;
                $unmodified = False;
            }
            else {
                push @transative_closures, $g;
            }
        }
        last if $unmodified;
        @groups = @transative_closures;
    }
    return @groups;
}
sub task2 ( @in ) {
    my %h;
    for @in.kv -> $i, ( $letter, *@addresses ) {
        for @addresses -> $add {
            %h{"$letter:$add"}.push: $i;
        }
    }

    my SetHash @groups = %h.sort.map({ .value.SetHash if .value.elems > 1 });

    my @to_merge = transative_closures(@groups).map( *.keys».Int.sort ).sort;

    my @r = @in;
    for @to_merge -> @tm {
        my ($target, @sources) = @tm;
        my @addresses = @r[@tm].map({ .skip }).flat.unique;
        @r[$target] = [ @r[$target].head, |@addresses ];
        @r[$_] = Nil for @sources;
    }

    return @r.grep(?*);
}


# To simplify the debugging output, all `@` have been replaced with `-`, and `.com` has been removed.
my @tests =
    # Task example 1
    [
        [
            [<A a1-a a2-a >],
            [<B b1-b      >],
            [<A a3-a a1-a >],
        ],
        [
            [<A a1-a a2-a a3-a >],
            [<B b1-b           >],
        ],
    ],
    # Task example 2
    [
        [
            [<A a1-a a2-a>],
            [<B b1-b     >],
            [<A a3-a     >],
            [<B b2-b b1-b>],
        ],
        [
            [<A a1-a a2-a >],
            [<A a3-a      >],
            [<B b1-b b2-b >],
        ],
    ],

    # From mark-anderson :
    [
        [
          [<C c2-c>],
          [<C c1-c c4-c>],
          [<A a1-a a2-a>],
          [<B b1-b>],
          [<A a3-a>],
          [<B b4-b b5-b b6-b>],
          [<C c1-c c3-c>],
          [<B b2-b b1-b>],
          [<A a3-a a4-a>],
          [<B b3-b>],
        ],
        [
          [<A a1-a a2-a>],
          [<A a3-a a4-a>],
          [<B b4-b b5-b b6-b>],
          [<B b1-b b2-b>],
          [<B b3-b>],
          [<C c2-c>],
          [<C c1-c c3-c c4-c>],
        ],
    ],
    # From e-choroba :
    [
        [
            [<A a1-a a2-a>],
            [<A b1-b a1-a>],
            [<A a3-a b1-b>],
        ],
        [
            [<A a1-a a2-a a3-a b1-b>],
        ],
    ],
    [
        [
            [<A a1-a a2-a>],
            [<A b1-b a1-a>],
            [<A a3-a b1-b>],
            [<A a3-a b2-b>],
        ],
        [
            [<A a1-a a2-a a3-a b1-b b2-b>],
        ],
    ],

    # From james-smith :
    [
        [
            [<A a1-a a2-a>],
            [<A a3-a a4-a>],
            [<A a2-a a4-a>],
        ],
        [<A a1-a a2-a a3-a a4-a>,],

    ],
    [
        [
            [<A a1-a a2-a>],
            [<A a2-a a3-a>],
            [<A a3-a a4-a>],
            [<A a4-a a5-a>],
            [<A a5-a a6-a>],
        ],
        [<A a1-a a2-a a3-a a4-a a5-a a6-a>,],
    ],
    [
        [
            [<A a1-a a2-a>],
            [<A a3-a a4-a>],
            [<A a5-a a6-a>],
            [<A a7-a a8-a>],
            [<A a1-a a3-a>],
            [<A a5-a a7-a>],
            [<A a1-a a5-a>],
        ],
        [<A a1-a a2-a a3-a a4-a a5-a a6-a a7-a a8-a>,],
    ],
;
use Test;
plan +@tests;
for @tests -> ( $in, @expected ) {
    my @got = task2($in).map(*.sort).sort;
    my @exp =  @expected.map(*.sort).sort;
    is-deeply @got, @exp;
}
