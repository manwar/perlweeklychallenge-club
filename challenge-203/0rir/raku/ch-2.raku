#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.d;
use Test;
use File::Directory::Tree;

=begin comment
203-2: Copy Directory           Submitted by: Julien Fiegehenn

Given path to two folders, $source and $target, recursively copy the
directory from $source to $target except any files.

Example
Input: $source = '/a/b/c' and $target = '/x/y'

Source directory structure:

├── a
│   └── b
│       └── c
│           ├── 1
│           │   └── 1.txt
│           ├── 2
│           │   └── 2.txt
│           ├── 3
│           │   └── 3.txt
│           ├── 4
│           └── 5
│               └── 5.txt

Target directory structure:

├── x
│    └── y

Expected Result:

├── x
│   └── y
│       ├── 1
│       ├── 2
│       ├── 3
│       ├── 4
│       └── 5
=end comment

my @Test =
    {  top  => 'a/b/c/',
       dest => 'x/y/',
       src  => [ '1/', '1/1.txt', '2/', '2/2.txt', '3/',
                    '3/3.txt', '4/', '5/', '5/5.txt' ],
       exp  => './sandbox/x:
y

./sandbox/x/y:
1
2
3
4
5

./sandbox/x/y/1:

./sandbox/x/y/2:

./sandbox/x/y/3:

./sandbox/x/y/4:

./sandbox/x/y/5:
',
    },
    {  top  => 'a/b/',
       dest => 'x/y/',
       src  =>
            ['c/d/e/1/', 'c/d/f/1/', 'c/d/f/2/', 'c/d/e/4/', 'c/d/e/4/4.txt',],
       exp  => './sandbox/x:
y

./sandbox/x/y:
c

./sandbox/x/y/c:
d

./sandbox/x/y/c/d:
e
f

./sandbox/x/y/c/d/e:
1
4

./sandbox/x/y/c/d/e/1:

./sandbox/x/y/c/d/e/4:

./sandbox/x/y/c/d/f:
1
2

./sandbox/x/y/c/d/f/1:

./sandbox/x/y/c/d/f/2:
'
    },
;

my $box = < ./sandbox >;

sub init-test( $test-num ) {
    my %h = @Test[$test-num];
    my $top = %h<top>;
    for @(%h<src>) -> $p {
        if $p ~~ / \w* '/' $ / {
            mkdir "$box/$top/$p".IO();
        } else {
            spurt "$box/$top/$p", " This is $p";
    }   }
    mkdir "$box/%h<dest>"
}

sub clean-test( --> Nil) { empty-directory $box; }

#  copy a directory tree's directories only
sub copy-dir-tree-struct( Str $src, Str $dest  ) {
    my @from;
    indir( $src, {
        my @todo = '.'.IO;
        @from = gather while @todo {
            for @todo.pop.dir -> $path {
                @todo.push: $path if $path.d;
                take $path.Str if $path.d;
    }   }   });
    indir( $dest, {
        for @from -> $dir-name { mkdir "$*CWD/$dir-name";}
    });
}

plan +@Test;

for 0..^@Test -> $n {
    init-test( $n );
    copy-dir-tree-struct( "$box/@Test[$n]<top>", "$box/@Test[$n]<dest>");
    my $result = qqx{ls -R $box/x};                        # XXX magic 'x'
    is $result, @Test[$n]<exp>;
    clean-test();
}

