use v6;

################################################################################
=begin comment

Perl Weekly Challenge 019
=========================

Task #2
-------
Write a script that can wrap the given paragraph at a specified column using the
[ https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap#Minimum_number_of_lines
|greedy algorithm].

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $COLUMN   = 79;
my UInt constant $INDENT   =  0;
my Str  constant $ERROR    = "\nError in command line arguments: ";
my Str  constant $SPACE    = ' ';
my UInt constant $SP_WIDTH = $SPACE.chars;

sub MAIN
(
    Str:D  :$file   = '',       #= name of file containing text to format
    Str:D  :$text   = '',       #= XOR text to format
    UInt:D :$column = $COLUMN,  #= column at which to wrap each paragraph (opt.)
    UInt:D :$indent = $INDENT,  #= number of spaces to indent first line (opt.)
)
{
    my Str $unwrapped = parse-command-line($file, $text, $column, $indent);
    my Str $wrapped   = '';

    for $unwrapped.split(rx{ \n }, :v) -> Cool $paragraph
    {
        if $paragraph eq "\n"
        {
            $wrapped ~= $paragraph;
        }
        else
        {
            $wrapped ~= line-wrap-greedy($column, $indent, $paragraph);
        }
    }

    print "\n", $wrapped;

    CATCH
    {
        default
        {
            $*ERR.say: .message;
        }
    };
}

sub parse-command-line
(
    Str:D  $file,
    Str:D  $text,
    UInt:D $column,
    UInt:D $indent,
--> Str:D
)
{
    $file.chars >  0 || $text.chars >  0
        or die "{$ERROR}missing filename or text\n$*USAGE";

    $file.chars == 0 || $text.chars == 0
        or die "{$ERROR}both filename and text given\n$*USAGE";

    $column > 0
        or die "{$ERROR}Cannot wrap at column zero\n$*USAGE";

    my Str $unwrapped;

    if $file.chars > 0
    {
        $unwrapped = $file.IO.slurp;

        $unwrapped.chars > 0
            or die "{$ERROR}empty file\n$*USAGE";
    }
    else
    {
        $unwrapped = $text;
        $unwrapped ~~ s:g/ \\n /\n/;
    }

    return $unwrapped;
}

sub line-wrap-greedy
(
    UInt:D $column,
    UInt:D $indent,
    Str:D  $paragraph,
--> Str:D
)
{
    $paragraph ~~ rx{ \n }
        and die "Line break in paragraph \"$paragraph\"";

    my Str $wrapped = '';

    if $paragraph.chars > 0
    {
        my @words = $paragraph.split: rx{ \s+ };

        # Indent the first word in the paragraph

               $wrapped   = ($SPACE x $indent) ~ @words.shift;
        my Int $remaining = $column - $wrapped.chars;

        # Place the remaining words in the paragraph using the greedy algorithm

        for @words -> Str $word
        {
            my UInt $length = $word.chars;

            if ($length + $SP_WIDTH) > $remaining    # Start a new line
            {
                $wrapped   ~= "\n" ~ $word;
                $remaining  = $column - $length;
            }
            else                                     # Continue the current line
            {
                $wrapped   ~= $SPACE ~ $word;
                $remaining -= $SP_WIDTH + $length;
            }
        }
    }

    return $wrapped;
}

################################################################################
