#!/usr/bin/perl

use v5.16;
use warnings;

# Mask all given arguments.
say mask4($_) for @ARGV;

sub mask4 {
    my $cnt = 0;
    our $c;
    # Replace the first four occurences of lower case letters or digits
    # with an 'x'.  Though there will not be any backtracking here, it
    # does not hurt considering it.  A slight modification of our task
    # would break the solution otherwise.  What if we were to mask the
    # first four occurences of the given characters followed by a dot in
    # the string abc.d.e.f.g?
    shift =~ s{
        [a-z0-9]                                # characters to be masked
        (?(?{(local $c = $cnt + 1) > 4})(*FAIL))    # first four,
                                                    # backtracking safe
        # (?=\.)                                # see comment above
        (?{$cnt = $c})                          # persist counter on success
    }{x}xgr;
}
