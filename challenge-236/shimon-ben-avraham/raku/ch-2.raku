#! /usr/bin/env raku

# Perl Weekly Challenge #236 Task 2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Wed 27 Sep 2023 08:58:34 PM EDT
# Version 0.0.1

# always use the latest version of Raku
use v6.*;

subset UniqueIntArry of Array where *.Set.elems == .elems and .all ~~ Int;

#| The actual program starts here.
multi MAIN (@ints) {
    my $num-elems = @ints.elems;
    my $index     = 0;
    my $start     = 0;
    my $next-index;
    my $cur-value;

    my @cur-loop;
    my @all-loops;
    LOOP:
    while $start < $num-elems {
        $next-index = $cur-value = @ints[$index];
        @cur-loop.push: $cur-value;
        @ints[$index] = Nil;
        given $next-index {
            when $start {
                @all-loops.push: @cur-loop;
                @cur-loop = ();
            }
            when $next-index ≥ $num-elems {
                @all-loops.push: for @cur-loop;
            }
        } # end of given $next-index
        $start = @ints.first: { $_.defined };
        last LOOP without $start;
    } # end of while $index < $num-elems
    say @all-loops.join("\n");
} # end of multi MAIN ( )

#| Run with the option '--test' to test the program
multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ got => '', op => 'eq', expected => '', desc => 'Example 1' },
    ];

    for @tests {
#        cmp-ok .<got>, .<op>, .<expected>, .<desc>;
    } # end of for @tests
} # end of multi MAIN (:$test!)

my %*SUB-MAIN-OPTS =
  :named-anywhere,             # allow named variables at any location
  :bundling,                   # allow bundling of named arguments
#  :coerce-allomorphs-to(Str),  # coerce allomorphic arguments to given type
  :allow-no,                   # allow --no-foo as alternative to --/foo
  :numeric-suffix-as-value,    # allow -j2 as alternative to --j=2
;

#| Run with '--doc' to generate a document from the POD6
#| It will be rendered in Text format
#| unless specified with the --format option.  e.g.
#|       --format=HTML
multi MAIN(Bool :$doc!, Str :$format = 'Text') {
    run $*EXECUTABLE, "--doc=$format", $*PROGRAM;
} # end of multi MAIN(Bool :$man!)