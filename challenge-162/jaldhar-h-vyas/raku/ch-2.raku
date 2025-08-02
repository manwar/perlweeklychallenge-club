#!/usr/bin/raku

sub decrypt(%table, %rtable, $m) {
    my @message = $m.lc.comb.grep({ /<[a .. z]>/ });
    if @message.elems % 2 {
        @message.push('x');
    }

    return @message
        .batch(2)
        .map({ transformDigraph(%table, %rtable, @$_[0], @$_[1], -1) })
        .join;
}

sub encrypt(%table, %rtable, $m) {
    my @message = $m.lc.subst(/ (.)$0 /, { "$0x$0" }, :g).comb.grep({ /<[a .. z]>/ });
    if @message.elems % 2 {
        @message.push('x');
    }

    return @message
        .batch(2)
        .map({ transformDigraph(%table, %rtable, @$_[0], @$_[1], 1) })
        .join;
}

sub makeTable(Str $k) {
    my @table = $k
            .lc
            .subst('j', 'i', :g)
            .comb
            .grep({ /<[a..z]>/ })
            .unique;

    @table.push(| (('a' .. 'i', 'k' ..'z') ∖ @table).keys.sort);

    return @table.values Z=> @table.keys;
}

sub transformDigraph(%table, %rtable, $a, $b, $dir) {
    my $aRow = %table{$a} div 5;
    my $aCol = %table{$a} % 5;
    my $bRow = %table{$b} div 5;
    my $bCol = %table{$b} % 5;
    if $aRow == $bRow {
        return %rtable{$aRow * 5 + (($aCol + $dir) % 5)} ~ %rtable{$bRow * 5 + (($bCol + $dir) % 5)};
    } elsif $aCol == $bCol {
        return %rtable{(($aRow + $dir) % 5) * 5 + $aCol} ~ %rtable{(($bRow + $dir) % 5) * 5 + $bCol};
    } else {
        return %rtable{$aRow * 5 + $bCol} ~ %rtable{$bRow * 5 + $aCol};
    }
}

multi sub MAIN (
    Bool :$d!,              #= decrypt a message
    Str :$k!,
    Str :$m!
) {
    my %table = makeTable($k);
    say decrypt(%table, %table.antipairs.Hash, $m);
}

multi sub MAIN (
    Bool :$e!,              #= encrypt a message
    Str :$k!,               #= key for encryption/decryption
    Str :$m!                #= message to encrypt/decrypt
) {
    my %table = makeTable($k);
    say encrypt(%table, %table.antipairs.Hash, $m);
}