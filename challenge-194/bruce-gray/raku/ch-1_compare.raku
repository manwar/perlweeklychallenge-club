sub task1 ( Str $s --> UInt ) {
    constant $OK_times = ( ^24 X ^60 ).map( *.fmt('%02d', ':') ).Set;

    return (9…0).first: { $s.subst( '?', $_ ) ∈ $OK_times };
}

sub task1_fully_precalculated ( Str $s --> UInt ) {
    constant %solution = gather for ( ^24 X ^60 ).map( *.fmt('%02d', ':') ) -> $t {
        for 0,1,3,4 -> $pos {
            my $was = $t.substr($pos, 1);
            my $tt = $t;
            $tt.substr-rw($pos, 1) = '?';
            take $tt => +$was;
        }
    }

    return %solution{$s} // die;
}

sub task1_regex_ternary ( Str $_ --> UInt ) {
    return / ^ \?       <[0..3]> ':' \d \d $ / ?? 2
        !! / ^ \?       <[4..9]> ':' \d \d $ / ?? 1
        !! / ^ <[0..1]>       \? ':' \d \d $ / ?? 9
        !! / ^ 2              \? ':' \d \d $ / ?? 3
        !! / ^ \d             \d ':' \? \d $ / ?? 5
        !! / ^ \d             \d ':' \d \? $ / ?? 9
        !!                                        die;
}

sub is_time_valid_1 ( Str $s --> Bool ) { # same as my `task1`, but extracted.
    constant $valid_times = ( ^24 X ^60 ).map( *.fmt('%02d', ':') ).Set;
    return $s ∈ $valid_times;
}
sub is_time_valid_2 ( Str $_ --> Bool ) {
    return /^ (<[0..9]> ** 2) ** 2 % ':' $/ && (
        ( $0[0] ~~ ^24  && $0[1] ~~ ^60  )
     # || ( $0[0] eq '24' && $0[1] eq '00' ) # Uncomment to make `24:00` OK.
    );
}
sub is_time_valid_3 ( Str $s --> Bool ) {
    # Alternate approach, condensed from the excellent code
    # of 冯昶 (feng-chang) and Jan Krňávek (wambash) :
    return ? try "{Date.today}T{$s}:00".DateTime;
}
sub task1_is_1 ( Str $s --> UInt ) { return (9…0).first: { $s.subst( '?', $_ ).&is_time_valid_1 } }
sub task1_is_2 ( Str $s --> UInt ) { return (9…0).first: { $s.subst( '?', $_ ).&is_time_valid_2 } }
sub task1_is_3 ( Str $s --> UInt ) { return (9…0).first: { $s.subst( '?', $_ ).&is_time_valid_3 } }

constant @tests =
    ( '?5:00', 1 ),
    ( '?3:00', 2 ),
    ( '1?:00', 9 ),
    ( '2?:00', 3 ),
    ( '12:?5', 5 ),
    ( '12:5?', 9 ),
;
use Test;
plan +@tests + 1;
for @tests -> ($in, $expected) {
    is task1($in), $expected, "task1($in) == $expected";
}

{
    my @subs =
        &task1,
        &task1_fully_precalculated,
        &task1_regex_ternary,
        &task1_is_1,
        &task1_is_2,
        &task1_is_3,
    ;

    # (10*60)+( 3*60)+(24*10)+(24* 6) = 1164 elements in @all_inputs.
    my @all_inputs = unique gather for ( ^24 X ^60 ).map( *.fmt('%02d', ':') ) -> $t {
        take $t.subst(:nth($_), /\d/, '?') for 1..4;
    }

    my $failed = False;
    for @all_inputs.sort -> $k {
        my @a = @subs.map: { .($k) };
        if @a[0] ne @a.all {
            $failed = True;
            note "Failed for Input: $k: ", @a.raku;
            last; 
        }
    }
    ok !$failed, "All subs agreed on all inputs";
}
