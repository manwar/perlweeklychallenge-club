#! /usr/bin/env raku

# Perl Weekly Challenge #236 Task 2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Thu 28 Sep 2023 08:29:39 PM EDT
# Version 0.0.1

# always use the latest version of Raku
use v6.*;

subset UniqueIntArray of Array where .elems == 0 ||
                                     .unique.elems == .elems and .all ~~ IntStr;

#| The actual program starts here.
multi MAIN (*@input where .all ~~ Int &&
                          .unique.elems == .elems,
            Bool :v($verbose) = False 
        ) {
    my Int @ints        = @input>>.Int;
    my Int $num-elems   = @ints.elems;
    my Int $start-index = 0;
    my Int $cur-index   = $start-index;

    my UniqueIntArray $cur-loop;
    my UniqueIntArray @all-loops;

    LOOP:
    while $start-index.defined {
        my $cur-value  = @ints[$cur-index];
        my $next-index = $cur-value;

        $cur-loop.push: $cur-value;
        @ints[$cur-index] = Nil;

        if $verbose {
            dd @ints;
            dd $start-index;
            dd $cur-index;
            dd $next-index;
            dd $cur-value;
            dd $cur-loop;
        } # end of if $verbose

        given $next-index {

            when * ≥ $num-elems {
                say "\e[31mFound singular loop[s]:\e[0m ",
                    $cur-loop.map({"[$_]"}).join(' ') if $verbose;
                @all-loops.push: for $cur-loop;
            }

            when $start-index {
                say "\e[32mFound a loop:\e[0m ",
                    $cur-loop.join(" ") if $verbose;
                @all-loops.push: $cur-loop;
            }

            default {
                say "\e[33mContinuing loop:\e[0m ",
                    $cur-loop.join(" ") if $verbose;
                $cur-index = $cur-value;
                next LOOP;
            }
        } # end of given $next-index

        $cur-loop = [];
        $start-index = $cur-index = @ints.first(*.defined, :k);

        say "\e[34m\nStarting new loop at index $start-index\e[0m"
            if $start-index.defined && $verbose;
    } # end of while $start-index.defined

    say "\n\n\e[35mAll loops:\n" ~ @all-loops.join("\n") ~ "\e[0m\n"
        if $verbose;

    say @all-loops.elems;
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