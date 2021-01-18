#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util 'min';

#
# First off, this is a very strange exercise. "push", "pop" and "top"
# are bog standard stack operations.
#
# min, however, is *NOT*. If you want a min operation, a stack is a
# horrible choice of datastructure, and you'd fail algorithms 101
# is that were your choice. Use a heap, or some kind of balanced tree.
#

my $ERROR = "Stack is empty";

my @stack;
while (<>) {
    if (/^push\s+(.*)/) {push @stack => $1}
    if (/^pop/)         {pop  @stack}
    if (/^top/)         {say  $stack [-1]  // $ERROR}
    if (/^min/)         {say  min (@stack) // $ERROR}
}

__END__
