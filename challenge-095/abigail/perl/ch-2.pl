#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

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
    chomp;
    if    (/^push\s+/p) {push @stack => ${^POSTMATCH}}
    elsif (/^pop/)      {pop  @stack}
    elsif (/^top/)      {say  $stack [-1] // $ERROR}
    elsif (/^min/) {
        #
        # Well, since we're asked to demonstrate stack operations
        # with "min", we won't be using List::Util::min, instead,
        # we will use a second stack....
        #
        my $min;
        my @other_stack;
        while (@stack) {
            my $top = pop @stack;
            $min = $top if !defined $min || $top < $min;
            push @other_stack => $top;
        }
        say $min // $ERROR;
        #
        # Restore the original stack.
        #
        push @stack => pop @other_stack while @other_stack;
    }
    else {
        die "Undefined command";
    }
}

__END__
