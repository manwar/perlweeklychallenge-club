#!/usr/bin/env raku

sub join-account (+@acc) {
     @acc.head.head, |@acc.map( |*.skip ).sort.squish;
}

sub merge-account-reducer ( @account, $email) {
    @account
    andthen .classify: { $email ∈ .skip }\
    andthen |(.{False} // Empty), join-account |.{True}
}

sub merge-account (+@accounts) {
    my @email =  @accounts.map( |*.skip ).unique;

    @accounts, |@email
    andthen .reduce: &merge-account-reducer
}

multi MAIN (Bool :test($)!) {
    use Test;
    my @accounts := <A a1@a.com a2@a.com>, <B b1@b.com>, <A a3@a.com a1@a.com>;
    is-deeply join-account( @accounts ), <A a1@a.com a2@a.com a3@a.com b1@b.com>;
    is-deeply join-account(
        <A a1@a.com a2@a.com>,  <A a3@a.com a2@a.com a1@a.com>
    ), <A a1@a.com a2@a.com a3@a.com>;
    is-deeply merge-account-reducer( @accounts, 'a1@a.com' ), (<B b1@b.com>,<A a1@a.com a2@a.com a3@a.com>);
    is-deeply merge-account-reducer( @accounts, 'a2@a.com' ), (<B b1@b.com>, <A a3@a.com a1@a.com>, <A a1@a.com a2@a.com>);
    is-deeply merge-account-reducer( @accounts, 'a3@a.com' ), (<A a1@a.com a2@a.com>,<B b1@b.com>, <A a1@a.com a3@a.com>);
    is-deeply merge-account( @accounts ), ( <B b1@b.com>, <A a1@a.com a2@a.com a3@a.com> );
    is-deeply merge-account( <A a1@a.com a2@a.com>, <B b1@b.com b2@b.com>, <A a3@a.com > ),
        (<A a1@a.com a2@a.com>, <B b1@b.com b2@b.com>, <A a3@a.com>);
    is merge-account( <A a1@a.com a2@a.com>, <B b1@b.com b2@b.com>, <A a3@a.com >, <A a4@a.com a1@a.com> ),
        (  <B b1@b.com b2@b.com>, <A a3@a.com>, <A a1@a.com a2@a.com a4@a.com>, );
    is-deeply merge-account( <A a b c>, <A a> ), ( <A a b c>,);
    is-deeply merge-account( <A a b c>, <A c d e>, <B x y>, <A d f> ), ( <B x y>, <A a b c d e f>,);
    done-testing;
}

multi MAIN (:@account) {
    say merge-account @account.map: *.words.list
}
