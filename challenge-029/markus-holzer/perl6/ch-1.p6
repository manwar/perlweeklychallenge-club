use Test;
use Data::Dump;

my %tests =

    #well-formed
     'A{1..3}'          => ["A1", "A2", "A3"],
     'B{1..6..2}'       => ["B1", "B3", "B5"],
     'B{6..2..2}'       => ["B6", "B4", "B2"],
     'B{6..2..-2}'      => ["B6", "B4", "B2"],
     'C{a..c}'          => ["Ca", "Cb", "Cc"],
     'C{c..a}'          => ["Cc", "Cb", "Ca"],
     'D{a..f..2}'       => ["Da", "Dc", "De"],
     'D{f..a..2}'       => ["Df", "Dd", "Db"],
     'D{f..a..-2}'      => ["Df", "Dd", "Db"],
     'E{1,2}'           => ["E1", "E2"],
     'F{1,2,3}'         => ["F1", "F2", "F3"],

    #malformed
    'A{a..c..d}'       => ['A{a..c..d}'],

    #nested
    'Ba..z..{1,2,3}'   => ["Ba..z..1", "Ba..z..2", "Ba..z..3"],
    'C{a,b,{1,2,3}}'   => ["Ca", "Cb", "C1", "C2", "C3"],

    #multiple
    '{a..b}X{1,2}'     => ["aX1", "bX1", "aX2", "bX2"];

for %tests.kv -> $test, $expected
{
    is-deeply( brace-expand( $test ).Array, $expected, $test );
}

grammar BraceExpansion
{
    regex TOP           { <start-txt> [ <list> | <range> ] <end-txt> }
    regex start-txt     { .* <?before [<list> || <range>]> }
    regex end-txt       { <save-char>*? }
    regex save-char     { <-[ \" \& \( \) \` \' \; \< \> \| \{ \} ]> }
    regex list-element  { <list> | <-[ \" \! \$ \& \( \) \` \' \; \< \> \|]>  }
    regex a-to-z        { <[ a..z A..Z ]> }
    regex num           { \-? <[ 0..9 ]>+ }
    regex range         { <alpha-range> | <num-range> }
    regex num-range     { \{ <num>  \. \. <num> [ \. \. <num> ]? \} }
    regex alpha-range   { \{ <a-to-z> \. \. <a-to-z> [ \. \.<num> ]? \} }
    regex list          { \{ <list-element>+ % ',' \} }
}


sub num-range( $match )
{
    my @num   = |$match<range><num-range><num>.list>>.Int;
    my @range = @num[0] ... @num[1];
    my $steps = ( @num[2] // 1 ).abs;
    @range.batch( $steps )>>.[0];
}


sub alpha-range( $match )
{
    my @num = |$match<range><alpha-range><a-to-z>.list>>.Str;
    my @range = @num[0] ... @num[1];
    my $steps = ( $match<range><alpha-range><num> // 1 ).abs;
    @range.batch($steps)>>.[0];
}

sub list( $match )
{
    $match<list><list-element>.list>>.Str;
}

sub brace-expand( $str )
{
    my $match = BraceExpansion.parse( $str );

    my @alternatives =
        $match<range><num-range>   ?? num-range( $match )   !!
        $match<range><alpha-range> ?? alpha-range( $match ) !!
        $match<list>               ?? list( $match )        !!
        ();

    return $str
        unless @alternatives;

    @alternatives
         .map( -> $element { $match<start-txt>.Str ~ $element ~ $match<end-txt>.Str } )
         .map( -> $result  { |brace-expand( $result ) } )
    ;
}