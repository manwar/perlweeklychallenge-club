#!/usr/bin/env raku

sub deep-walk (:$start= '.'.IO, :&deep = *.dir, :&test = *.d --> Supply) {
        my sub supply-gen ( $start ) {
            for deep( $start ) {
                .emit;
               when &test { supply-gen $_} ;
            }
        };
    supply supply-gen $start;
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply deep-walk(:start(1,(2,(3,4))), :deep(*.list), :test(* !~~ Int) ).grep( * ~~ Int).list, (1,2,3,4);
    my $source = 'a/b/c' => (
        1 => ('1.a' =>'a.txt', '1.txt'),
        2 => '2.txt',
        3 => '3.txt',
        4 => Empty,
        5 => '5.txt',
    );
    is-deeply deep-walk( :start($source), :deep(*.value), :test( * ~~ Pair ) ).grep( * ~~ Pair).map(*.key).list, (1,'1.a',2,3,4,5);
    done-testing;
}

multi MAIN ( IO() $from, IO() $to = '.'.IO, Bool :no-act(:$n) = False, Bool :verbose(:$v) = False  )  {
    deep-walk start => $from
    andthen .grep: *.d
    andthen .map: { $to.add( $_.subst: / ^ $from / ) }\
    andthen {
        .tap( *.say )   if $n|$v;
        .tap( *.mkdir ) if $v;
    }
}
