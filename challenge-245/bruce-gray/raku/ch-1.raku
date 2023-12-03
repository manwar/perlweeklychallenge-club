sub task1 (@language,   @popularity) {
    die if @language != @popularity;

    # This version reads like the task description.
    my %pop = @language Z=> @popularity;
    return @language.sort({ %pop{$^a} })

    # Lots of different ways to do it, varying in clarity vs brevity,
    # with some relying on omitted details of the task description
    # or small test cases (e.g. there are no ties in popularity).
    # Any of these single-statement solutions will work:
    #
    # return (@popularity Z @language).sort( + *.[0] )».[1];
    #
    # return ( +«@popularity Z @language ).sort».[1];
    #
    # return @language[ @language.keys.sort({ +@popularity[$_] }) ];
    #
    # return @language[ @popularity.antipairs.sort».value ];
    #
    # return (@popularity Z @language).map( { %( <pop lang> Z=> .list ) }).sort(+ *.<pop>)».<lang>;
    #
    # return map   *.<language>,
    #        sort +*.<popularity>,
    #        map { %( <popularity language> Z=> .list ) },
    #        ( @popularity Z @language );
    #
    # return @language.sort({ + .{$^a} }) given %( @language Z=> @popularity );
}
my @tests =
    ( (2, 1, 3), <perl c python>    , <c perl python>    ),
    ( (1, 3, 2), <c++ haskell java> , <c++ java haskell> ),
;
use Test; plan +@tests;
for @tests -> ( @popularity, @lang, @expected ) {
    is-deeply task1(@lang, @popularity), @expected;
}
