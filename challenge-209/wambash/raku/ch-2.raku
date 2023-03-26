#!/usr/bin/env raku

class Account {
    has $.name;
    has Set() $.email;

    multi method COERCE (+@ (Str $name, +@email)) {
        Account.new: :$name, :@email
    }

    multi method List {
        $!name, |$!email.keys.sort
    }
}


multi join-account (+@acc) {samewith @acc}
multi join-account (Array[Account()]() \acc) {
    Account.new: name => acc.head.name, email => [(|)] acc».email;
}

sub merge-account-reducer ( @accounts, $email) {
    @accounts
    andthen .classify: { $email ∈ .email }\
    andthen |.{False}, join-account |.{True}
}

multi merge-account (+@acc) {samewith @acc}
multi merge-account (Array[Account()]() \accounts) {
    my @email = ([∪] accounts.map( *.email)).keys;

    accounts, |@email
    andthen .reduce: &merge-account-reducer
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply Account('A', 'a1@a.com', 'a2@a.com').email,  <a1@a.com a2@a.com>.Set;
    is Account(<B b@b.com>).name, 'B';
    is-deeply join-account(
        <A a1@a.com a2@a.com>, <B b1@b.com>, <A a3@a.com a1@a.com>
    ).email, <a1@a.com a2@a.com b1@b.com a3@a.com>.Set;
    is-deeply join-account(
        <A a1@a.com a2@a.com>, <B b1@b.com>, <A a3@a.com a1@a.com>
    ).name, 'A';
    is-deeply merge-account-reducer(
        Array[Account()](<A a1@a.com a2@a.com>, <B b1@b.com>, <A a3@a.com a1@a.com>),
        'a1@a.com'
    )».email, (<b1@b.com>.Set, <a1@a.com a2@a.com a3@a.com>.Set)  ;
    is-deeply merge-account( <A a1@a.com a2@a.com>, <B b1@b.com>, <A a3@a.com a1@a.com> ).sort(*.name).head.email,
    <a1@a.com a2@a.com a3@a.com>.Set;
    is merge-account( <A a1@a.com a2@a.com>, <B b1@b.com>, <A a3@a.com a1@a.com> )».List.sort,
       (<A a1@a.com a2@a.com a3@a.com>, <B b1@b.com>);
    is merge-account( <A a1@a.com a2@a.com>, <B b1@b.com b2@b.com>, <A a3@a.com > )».List.sort,
       (<A a1@a.com a2@a.com>, <A a3@a.com>, <B b1@b.com b2@b.com>);
    is merge-account( <A a1@a.com a2@a.com>, <B b1@b.com b2@b.com>, <A a3@a.com >, <A a4@a.com a1@a.com> )».List.sort,
       (<A a1@a.com a2@a.com a4@a.com>, <A a3@a.com>, <B b1@b.com b2@b.com>);
    done-testing;
}

multi MAIN (@account) {
    say merge-account @account
}
