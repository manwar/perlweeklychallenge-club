#!/bin/env raku

grammar Tree {
    rule  TOP  { '(' <node> <TOP> ** 0..2 ')' }
    token node { \d+ }
}

class TreeActions {
    method TOP($/) {
        my %h = root => $<node>.made;
        %h<left>  = $<TOP>[0].made if $<TOP>[0];
        %h<right> = $<TOP>[1].made if $<TOP>[1];

        make %h;
    }

    method node($/) { make $/.Int }
}

multi MAIN('test') {
    use Test;

    is-deeply Tree.parse('(111)', :actions(TreeActions)).made, { root => 111 }, '(111) parsed';
    is-deeply
        Tree.parse('(6 (2) (3))', :actions(TreeActions)).made,
        { root => 6, left => { root => 2 }, right => { root => 3 } },
        '(6 (2) (3)) parsed';

    done-testing;
}

sub tree-sum($t --> Int:D) {
    $t ?? $t<root> + tree-sum($t<left>) + tree-sum($t<right>) !! 0
}

sub modify-tree($t, Int:D $sum) {
    return unless $t;

    $t<root> = $sum - $t<root>;
    modify-tree($t<left>,  $sum);
    modify-tree($t<right>, $sum);
}

sub print-tree(Hash:D $t) {
    print '(', $t<root>;

    if $t<left>.defined {
        print ' ';
        print-tree($t<left>);
    }

    if $t<right>.defined {
        print ' ';
        print-tree($t<right>);
    }

    print ')';
}

multi MAIN(Str:D $t = '(1(2(4(7)))(3(5)(6)))') {
    my Hash $tree .= new(Tree.parse($t, :actions(TreeActions)).made);

    my $sum = tree-sum($tree);
    modify-tree($tree, $sum);

    print-tree($tree);
    put '';
}
