sub task2_splice_zip ( @ns ) {
    my @a = @ns.sort(+*);
    my @y = @a;
    my @x = @y.splice(0, * div 2);
    return flat ( @x.reverse Z @y.reverse );
}
sub task2_skip_head_zip ( @ns ) {
    my @a = @ns.sort(-*);
    my @x = @a.skip(+@a div 2);
    my @y = @a.head(+@a div 2);
    return flat ( @x Z @y );
}
multi sub task2_scsv ( @ns where * %% 2 ) {
    return flat [Z] @ns.sort(-*).classify({ $++ < (+@ns div 2) }).sort».value;
    # Or:
    # return @ns.sort(-*).sort({ ($++).polymod(+@ns div 2) Z* (1,-1) });
}
multi sub task2_scsv ( @ns where * !%% 2 ) {
    my @r = @ns.sort(-*);

    my $z = @r.pop;
    @r = samewith(@r);
    @r.push($z);

    return @r.List;
}
sub task2_feed_by_key ( @ns ) {
    my @s = @ns.sort(-*);

    my @r;
    @r[ .key * 2 + 1 ] = .value for @s.head(+@s div 2).pairs;
    @r[ .key * 2 + 0 ] = .value for @s.skip(+@s div 2).pairs;

    return @r.List;
}


my @tests =
    ( (1,5,1,1,6,4) , (1,6,1,5,1,4) ),
    ( (1,3,2,2,3,1) , (2,3,1,3,1,2) ),
    ( (3,4,5,6,7  ) , (5,7,4,6,3) ),
;
sub is-wiggly ( @ns --> Bool ) {
    return ?(   @ns.skip(0).rotor(2).map({ .[0] < .[1] }).all
            and @ns.skip(1).rotor(2).map({ .[0] > .[1] }).all );
}
# Pre-check that all the expected results are valid.
for @tests -> ($in, $expected) {
    # .[0] < .[1] > .[2] or die for $expected.list.rotor(3 => -1); #XXX world not check if < 3 elements
    .[0] < .[1] or die for $expected.skip(0).rotor(2);
    .[0] > .[1] or die for $expected.skip(1).rotor(2);
    .&is-wiggly or die for $expected;
    $in.elems == $expected.elems or die;
}

my @subs =
    :&task2_splice_zip,
    :&task2_skip_head_zip,
    :&task2_feed_by_key,
    :&task2_scsv
;
my Set $sub_names_that_can_handle_even_and_odd = set <
    task2_scsv
    task2_feed_by_key
>;

die "Duplicate seen!" if @subs».key.repeated;
if $sub_names_that_can_handle_even_and_odd (-) @subs>>.key.Set -> Set $bad {
    die "Sub name not in @subs : $bad";
}

use Test;
plan +@tests * +@subs;

for @tests -> ($in, $expected) {
    my $test_num = ++$;

    for @subs {
        my ( $sub_name, $sub_code ) = .kv;
        if $in.elems !%% 2 and !($sub_name (elem) $sub_names_that_can_handle_even_and_odd) {
            skip "Cannot handle odd sizes : $test_num : $sub_name ";
            next;
        }

        is-deeply $sub_code.($in), $expected, "$test_num : $sub_name";
    }
}
