#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# I have a very hard time of mapping the instructions for a relational
# database to perl. Mainly, how to translate "If the size of the hash
# table equals the maximum in-memory size"? Perl's solution to filling
# up all memory is to crash. You certainly would not be able to add
# anything to an existing structure.
#
# And it seems it is necessary to deal with cases not fitting into memory,
# as the stated algorithm is explicitly used for the case it doesn't fit
# into memory. The quote the line above the quoted algorithm:
#
#    This algorithm is simple, but it requires that the smaller join
#    relation fits into memory, which is sometimes not the case.
#    A simple approach to handling this situation proceeds as follows: 
#
# So, we're not asked to implement the classic hash join algorithm when
# everything neatly fits into memory, but the case where it doesn't.
# Which makes me really wonder, on what piss poor hardware is the 
# weekly challenge running where the given example doesn't fit in memory?
#
# There is a way out of this, but it requires a special compiled perl.
# If your Perl has been compiled with the -DPERL_EMERGENCY_SBRK option,
# and if it is using Perl's own malloc, then you can allocate some
# emergency memory using $^M. So, we check if those conditions are set,
# and allocate some emergency memory. 
#
# Whenever we run out of memory, this is trapped, and we flush the
# output so far, using the given algorithm.
#
# NOTE: This is a very flimsy algorithm, and will most likely result
#       in losing some data. But hey, if you want us to implement an
#       algorithm in Perl which deals with running out of memory, this
#       is the best you can get.
#       This is also gambling the state of the program is such that
#       we can actually continue after running out of memory. This
#       is not very likely.
#
# NOTE: This is completely untested. I couldn't be bothered to recompile
#       my perl.
#

#
# First check if we can define emergency memory. If not, no hash join for you.
# Else, define some emergency memory.
#

use Config;
use List::Util 'max';

BEGIN {
    die "No hash join for you -- recompile first!\n" unless
        $Config::Config {malloc_cflags} =~ /-DPERL_EMERGENCY_SBRK\b/ &&
        $Config::Config {usemymalloc} eq 'y';

    $^M = " " x (1 << 20);  # 1 Mb. 
}

my @R = (
    [20, "Alex" ],
    [28, "Joe"  ],
    [38, "Mike" ],
    [18, "Alex" ],
    [25, "David"],
    [18, "Simon"],
);

my @S = (
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ],
);

my $idx_R_njk = 0;
my $idx_R_jk  = 1;  # Join key
my $idx_S_jk  = 0;  # Join key
my $idx_S_njk = 1;

#
# To pretty print.
#
my $max_width = 3 + max map {length $$_ [$idx_R_jk]} @R;

my %output;

#
# Whenever we run out of memory, we trap this, and flush the output.
# This ought to release memory.
#
$SIG {__DIE__} = sub {
    if ("@_" =~ /Out of memory/) {
        flush (\@S, $idx_S_jk, \%output)
    }
    else {
        die @_;  # Propagate
    }
};

sub flush ($S, $idx_S_jk, $output) {
    undef $^M;  # Release memory. 
                # Does this actually work this way? Or is $^M the only
                # memory we can use? In that case, this entire program
                # is not going to work.

    #
    # Scan $S. For each match in $output, output a line.
    #
    foreach my $entry (@$S) {
        if ($$output {$$entry [$idx_S_jk]}) {
            for (my $i = 0; $i < @{$$output {$$entry [$idx_S_jk]}}; $i ++) {
                printf qq [%2d, %-${max_width}s "%s"\n],
                                 $$output {$$entry [$idx_S_jk]} [$i],
                           '"' . $$entry [$idx_S_jk] . '",',
                                 $$entry [$idx_S_njk];
            }
        }
    }

    #
    # Reset output table
    #
    %$output = ();

    #
    # Claim emergency memory again
    #
    $^M = " " x (1 << 20);
}

#
# Main loop. 
#
foreach my $r (@R) {
    push @{$output {$$r [$idx_R_jk]}} => $$r [$idx_R_njk];
}


flush (\@S, $idx_S_jk, \%output);

__END__
