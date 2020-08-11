use v6;

################################################################################
=begin comment

Perl Weekly Challenge 032
=========================

Task #2
-------
Contributed by Neil Bowers

ASCII bar chart

Write a function that takes a hashref where the keys are labels and the values
are integer or floating point values. Generate a bar graph of the data and dis-
play it to stdout.

The input could be something like:

  $data = { apple => 3, cherry => 2, banana => 1 };
  generate_bar_graph($data);

And would then generate something like this:

   apple | ############
  cherry | ########
  banana | ####

If you fancy then please try this as well: (a) the function could let you speci-
fy whether the chart should be ordered by (1) the labels, or (2) the values.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my Str  constant $BAR-CHARACTER   = '#';
my UInt constant $BAR-MULTIPLIER  =  4;
my Bool constant $ORDER-BY-LABELS =  False;
my Bool constant $ORDER-BY-VALUES =  True;

BEGIN say '';

#===============================================================================
sub MAIN()
#===============================================================================
{
    my Real %data = cherry     => 2,
                    apple      => 1.5,
                    banana     => 3,
                    watermelon => 2,
                    mango      => 3.8;

    my Str $graph = generate-bar-graph(%data, $ORDER-BY-LABELS);
           $graph.say;

           $graph = generate-bar-graph(%data, $ORDER-BY-VALUES);
           $graph.print;
}

#-------------------------------------------------------------------------------
sub generate-bar-graph
(
    Real:D %data,
    Bool:D $by-values = False,
--> Str:D
)
#-------------------------------------------------------------------------------
{
    my Str @keys = %data.keys;

    if $by-values   # Order by values
    {
        @keys = @keys.sort:
                {
                    %data{$^b} <=> %data{$^a}       # Descending
                    ||                              #    then
                    $^a cmp $^b                     # Lexicographical
                };
    }
    else            # Order by labels
    {
        @keys = @keys.sort;                         # Lexicographical only
    }

    my UInt $width = @keys.map( { .chars } ).max;
    my Str  $graph = '';

    for @keys -> Str $key
    {
        my Str $bar = $BAR-CHARACTER x ($BAR-MULTIPLIER * %data{$key});
        $graph     ~= "  %*s | %s\n".sprintf: $width, $key, $bar;
    }

    return $graph;
}

################################################################################
