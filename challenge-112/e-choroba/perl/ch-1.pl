#!/usr/bin/perl
use warnings;
use strict;

sub canonical_path {
    my ($path) = @_;
    my @steps = grep length && $_ ne '.', split m{/}, $path;
    for (my $pos = 0; $pos <= $#steps; ++$pos) {
        if ('..' eq $steps[$pos]) {
            if ($pos > 0) {
                splice @steps, $pos - 1, 2;
                $pos -= 2;
            } else {
                splice @steps, $pos--, 1;
            }
        }
    }
    return '/' . join '/', @steps
}

use Test::More;

is canonical_path('/a/'), '/a', 'Example 1';
is canonical_path('/a/b//c/'), '/a/b/c', 'Example 2';
is canonical_path('/a/b/c/../..'), '/a', 'Example 3';

is canonical_path('/a/./b/./c/.'), '/a/b/c', 'Single dots';
is canonical_path('/a/b/../c/../d'), '/a/d', 'Double dots';
is canonical_path('/a/b/../../../../c'), '/c', 'Too many double dots';  # (*)
is canonical_path('/../a'), '/a', 'Double dots at the beginning';
is canonical_path('/../..'), '/', 'Only double dots at the beginning';

done_testing();

=heading1 COMMENTS

(*) This test and the following ones mimic the shell's behaviour for
existing paths only, e.g. /usr/share/../../../bin resolves to /bin,
but /usr/NONEXISTENT/../../../bin fails.

In fact, on *nix with symlinks involved, you can't resolve .. without
checking the actual file system. For example,

 $ mkdir 1 2
 $ ln -s ../1 2/0
 $ ls 2/0/../1

The last command lists 1, not 2/1 (which doesn't exist).

=cut
