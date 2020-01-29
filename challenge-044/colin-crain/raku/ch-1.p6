use v6.d;

#
#
#       one_hundred.p6
#
#         PWC 44 - TASK #1
#         "Only 100, please."
#             You are given a string “123456789”. Write a script that would
#             insert ”+” or ”-” in between digits so that when you evaluate, the
#             result should be 100.
#
#
#
#         method:

#         EVAL vs. eval ""

#         1. The logic for the perl 5 version of this solution is
#             strightforward, and we'll repeat it here. We build a list of
#             strings containing combinations of '+', '-' or nothing between
#             the digits in the source string, then treat that string as code
#             and see whether it adds to 100. It's a fair number of
#             iterations to got through, but nothing crazy. Profiling the
#             code states it runs for me in 230ms to produce the 11
#             solutions:

#             For the list (1, 2, 3, 4, 5 , 6, 7, 8, 9) there are 9 elements, or
#             8 interelemental spacings for operators.
#
#             Each operator can be one of '+' '-' or '~', signifying merging the
#             two numbers into one number 10a+b (being the same as not splitting
#             the original string at all at that point, or doing nothing)
#
#             3 choices 8 times yields 3^8 permutations with repetition, or 6561
#             equations to be considered.
#
#             The 'merge' operator a~b is associative to itself,
#                 (1~2)~3 = 1~(2~3) = 123
#             however
#                 (1+2)~3 != 1+(2~3)
#             thus it has higher precedence than the others and must be
#             evaluated first. By concatenating a~b into the equation string
#             during construction as 'ab' this is accomplished positionally
#             rather than mathematically and precedence order is maintained.
#
#             the resultant string, containing only left-associative operators
#             can now be eval'd left to right and compared to 100
#
#         2. Directly translating the logic to raku, including the lines:

#                 use MONKEY-SEE-NO-EVAL;
#                 printf "%-30s = 100\n", $_ if EVAL($_) == 100;
#
#             is painfully, ridiculously slow. The same 6561 evaluations took a
#             full 55 seconds, and it is not clear what is happening here, but
#             it's using an inordinant amount of memory doing so. Adding the
#             profiler eats everything available until segfault so we can't use
#             that. But assuming it's the EVAL (spoiler: it's the EVAL), we
#             rewrite that as a specific calculator subroutine that dices the
#             string and computed the total, bringing the elapsed time down to
#             about 3000ms. Inlining that subroutine got us to 2171, and
#             replacing shift with an explicit index, keeping the array of
#             equations intact as shown below brings us to 1623ms, which is
#             still about 7x slower than Perl5 for the same logic. I think this
#             qualifies as a solution, if not a great one. Further efforts
#             didn't prove fruitful, and getting this time down further will
#             presumably require a complete reworking of the methodology.
#

#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


sub MAIN () {
#     my $start = BEGIN { DateTime.now };         ## our timer init

    my $string = "123456789";
    my @list = $string.comb;
    my @equations = @list.shift;
    my $idx = 0;

    ## for each element of the existing list, remove and replace it in place
    ## with 3 new elements suffixed with the next operator and operand
    ## -- 9840 iterations to produce 6561 elements
    for @list -> $new {
        while my $target = @equations.splice($idx, 1) {
            for (' + ', ' - ', '') {
                @equations.splice( $idx, 0, "$target$_$new" );
                $idx++;
            }
        }
        ## restart from beginning of list as each number is added to the strings
        $idx = 0;
    }

#     say DateTime.now - $start ;  ## isolate the top from the bottom

    ## inline the filter sub
    my @valid;
    for @equations {
        my @eq = $_.split( /<[-+]>/, :v);
        my $total;

        my $idx = 0;
        while ($idx < @eq.elems) {
            given @eq[$idx] {
                when "+"       { $idx++; $total += @eq[$idx] }
                when "-"       { $idx++; $total -= @eq[$idx] }
                default        { $total = $_  }
            }
            $idx++;
        }
        @valid.push: $_ if $total == 100;
    }

    ## output
    printf "%-30s = 100\n", $_ for @valid;  ## roll your own

#     END { say DateTime.now - $start };  ## report
}
