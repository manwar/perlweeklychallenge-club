#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;

constant TEST=False;

=begin comment
Task 182--2: Common Path Submitted by: Julien Fiegehenn
Given a list of absolute Linux file paths, find the deepest directory
pathname that contains all of them.
  Example
Input:
    /a/b/c/1/x.pl
    /a/b/c/d/e/2/x.pl
    /a/b/c/d/3/x.pl
    /a/b/c/4/x.pl
    /a/b/c/d/5/x.pl

Ouput:
    /a/b/c
=end comment

=begin comment
 NOTE:
    Call me lazy.  I am taking the "Linux file paths" in a traditional way
    to disallow:
    ∘ those containing device, file attribute, or remote host info
        or having case insensitivity;
    ∘ those containing whitespace, escaped chars, or chars special in sh, csh, etc.;
    ∘ those having directories named by the aliases '.' or '..', or no-op dirs '//';
    ∘ those on very-Linux filesystems that are not user-domain filesystems 
        these include nosysfs, noproc, notmpfs, nocgroup, noautofs,
        nosecurityfs, nomqueue, nodebugfs, nohugetlbfs, nofusectl,
        nofuse.gvfsd-fuse, and norpc_pipefs;
=end comment

sub longest-common-prefix (List:D $a --> Str) {
    die 'ERROR: Got undefined value' unless $a.all.defined;
    return @$a[0] if 1 == @$a;

    # after https://rosettacode.org/wiki/Longest_common_prefix#Raku
    quietly substr @$a[0], 0, [+] [\and] [Zeq] @$a».comb;   # ??? () --> ''
}

sub common-path ( @path --> Str) {
    for @path {
        die 'Bad path name' if / '//' | '/../' | '/./' / ;
    }
    my $ret = longest-common-prefix (@path);
    return $ret if $ret eq '/';
    $ret.=subst( / '/' <-[/]> * $ /,  '' );
}

if TEST {
    my @Test-prefix =
        { in => ( '', ),                 exp => '' },
        { in => ( 'dog', ),              exp => 'dog' },
        { in => ( 'dog', 'dog' ),        exp => 'dog' },
        { in => ( 'dog', 'dog', 'dog' ), exp => 'dog' },
        { in => ( 'dog', 'dogs', ),      exp => 'dog' },
        { in => ( 'dog', 'cat' ),        exp => '' },
        { in => ( 'dog', 'cat' ),        exp => '' },
    ;
    my @Test =
        { in =>  (
            '/a/b/c/1/x.pl',
            '/a/b/c/d/e/2/x.pl',
            '/a/b/c/d/3/x.pl',
            '/a/b/c/4/x.pl',
            '/a/b/c/d/5/x.pl', ),       exp => '/a/b/c',
        },
        { in =>  (
            '/a/b/x.pl',
            '/a/b/x.pl',
            '/a/b/x.pl', ),       exp => '/a/b',
        },
        { in =>  (
            '/a/b/x.pl',
            '/x.pl',
            '/a/b/c/d/5/x.pl', ),       exp => '/',
        },
    ;
    my @Death = ( 
        ('/a//b/c/e/2/x.pl',      '/a//b/c/3/x.pl',   '/a//b/c/4/x.pl'),
        ('/a/b/c/e/2/../x.pl',    '/a/b/c/3/../x.pl', '/a/b/c/4/../x.pl'),
        ('/a/b/c/e/2/x.pl',       '/a/b/c/3/x.pl',    '/a/b/c/4/./x.pl'),
        ('/a/b/c/e/2/./x.pl',     '/a/b/c/3/x.pl',    '/a/b/c/4/x.pl'),
        ('/a/b/c/e/2/..//./x.pl', '/a/b/c/3/x.pl',    '/a/b/c/4/x.pl'),
    );

    plan + @Test-prefix + @Test + @Death;

    for @Test-prefix -> %t {
        is longest-common-prefix(%t<in>), %t<exp>, 'longest-common-prefix';
    }
    for @Test -> %t {
        is common-path(%t<in>), %t<exp>, 'common-path';
    }
    for @Death -> @l {
        dies-ok { common-path( @l) },  "Dies on @l[0]";
    }
    done-testing;
    exit;
}

sub MAIN( @p = ('/a/b/c/1/x.pl',
            '/a/b/c/d/e/2/x.pl',
            '/a/b/c/d/3/x.pl',
            '/a/b/c/4/x.pl',
            '/a/b/c/d/5/x.pl', )  ) {
    say 'Input:';
    say "    ", $_ for @p;
    say "\nOutput: ";
    say '    ', common-path( @p);
}

