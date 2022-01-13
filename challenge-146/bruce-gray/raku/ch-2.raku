sub task2 ( Str $s where /^\d+\/\d+$/ ) {

    my Rat $r = [/] $s.split('/');

    my @lineage = $r, &Calkin-Wilf-tree-parent ^… 1/1;

    return @lineage.head(2).map( *.nude.join('/') );
}
sub Calkin-Wilf-tree-parent ( Rat $r --> Rat ) {
    my ( Int \n, Int \d ) =     $r.nude;
    my   Int \diff        = [-] $r.nude;

    return diff > 0
        ?? diff /  d
        !!    n / -diff;
}

sub run-test-suite ( ) {
    constant $comment_re = / \s* '#' .* $ /;
    my @tests = './Test_data/ch-2_tests.txt'.IO.lines».subst($comment_re).map({ .words if /\S/ });

    use Test;
    plan +@tests;
    for @tests -> ( Str $in, Str $exp1, Str $exp2 ) {
        my ( Str $got1, Str $got2 ) = task2($in);

        is-deeply ($got1, $got2), ($exp1, $exp2), "task2($in) == $exp1, $exp2";
    }
}
multi sub MAIN ( Rat $rational_number ) { say task2($rational_number) }
multi sub MAIN (                      ) { run-test-suite() }
