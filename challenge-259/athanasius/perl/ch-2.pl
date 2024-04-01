#!perl

################################################################################
=comment

Perl Weekly Challenge 259
=========================

TASK #2
-------
*Line Parser*

Submitted by: Gabor Szabo

You are given a line like below:

  {%  id   field1="value1"    field2="value2"  field3=42 %}

Where

  a) "id" can be \w+.
  b) There can be 0  or more field-value pairs.
  c) The name of the fields are \w+.
  b) The values are either number in which case we don't need double quotes or
     string in which case we need double quotes around them.

The line parser should return structure like below:

  {
         name => id,
         fields => {
             field1 => value1,
             field2 => value2,
             field3 => value3,
         }
  }

It should be able to parse the following edge cases too:

  {%  youtube title="Title \"quoted\" done" %}

and

  {%  youtube title="Title with escaped backslash \\" %}

BONUS: Extend it to be able to handle multiline tags:

  {% id  filed1="value1" ... %}
  LINES
  {% endid %}

You should expect the following structure from your line parser:

  {
         name => id,
         fields => {
             field1 => value1,
             field2 => value2,
             field3 => value3,
         }
         text => LINES
  }

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single command-line argument specifies the (path and) filename of the file
   from which the input data is to be read.

Assumptions and Notes
---------------------
1. Within fields, "number" values are integers.
2. Within fields, "string" values do not contain control codes.
3. Non-record lines are silently ignored.
4. The BONUS has not been attempted.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $BS_CODE => chr 1;
const my $QU_CODE => chr 2;
const my $USAGE   => <<END;
Usage:
  perl $0 <file>
  perl $0

    <file>    Filename of the input data
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 259, Task #2: Line Parser (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $file = $ARGV[ 0 ];

        open( my $fh, '<', $file )
                  or error( qq[Can't open file "$file" for reading] );

        my $records = parse_lines( $fh );
        my $number  = 1;

        for my $record (@$records)
        {
            if (defined $record)
            {
                print "\n" if $number > 1;
                print "Record $number\n";
                print_record( $record );
                ++$number;
            }
        }

        close $fh or die qq[Can't close file "$file"\n];
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub parse_lines
#-------------------------------------------------------------------------------
{
    my ($fh) = @_;
    my  @records;

    while (my $line = <$fh>)
    {
        if ($line =~ / ^ \s* \{ \% \s+ (\w+) (?: \s+ (.*) )? \s+ \% \} \s* $ /x)
        {
            my %record;

            $record{ name } = $1;

            if (my $fields = $2)
            {
                $fields =~ s/ \\ \\ /$BS_CODE/gx;
                $fields =~ s/ \\ \" /$QU_CODE/gx;

                while ($fields)
                {
                    $fields =  parse_field( $fields, \%record );
                    $fields =~ s/ ^ \s+ //gx;
                }
            }

            push @records, { %record };
        }
        else
        {
            push @records, undef;                         # Required for testing
        }
    }

    return \@records;
}

#-------------------------------------------------------------------------------
sub parse_field
#-------------------------------------------------------------------------------
{
    my ($fields, $record) = @_;
    my  $field_length     = 0;

    if    ($fields =~ / ^ (\w+) \= ($RE{num}{int}) /x)
    {
        my ($name, $number) = ($1, $2);

        push $record->{ fields }->@*, [ $name => $number ];

        $field_length = length "$name=$number";
    }
    elsif ($fields =~ / ^ (\w+) \= \" (.*?) \" /x)
    {
        my ($name, $string) = ($1, $2);

        $string =~ s/ $BS_CODE /\\/gx;
        $string =~ s/ $QU_CODE /"/gx;

        push $record->{ fields }->@*, [ $name => $string ];

        $field_length = length qq[$name="$string"];
    }
    else
    {
        die qq[Invalid field in "$fields"];
    }

    substr $fields, 0, $field_length, '';

    return $fields;
}

#-------------------------------------------------------------------------------
sub print_record
#-------------------------------------------------------------------------------
{
    my ($record) = @_;

    print  "{\n";
    printf "    name   => %s\n", $record->{ name };
    print  "    fields =>\n";
    print  "    {\n";

    for my $field (@{ $record->{ fields } })
    {
        my $key   = $field->[ 0 ];
        my $value = $field->[ 1 ];

        if ($value =~ / ^ $RE{num}{int} $ /x)
        {
            print qq[        $key => $value\n];
        }
        else
        {
            print qq[        $key => "$value"\n];
        }
    }

    print  "    }\n";
    print  "}\n";
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    my $records = parse_lines( *DATA );

    for my $i (1 .. 6)
    {
        my $expected = get_expected( $i );

        is_deeply $records->[ $i - 1 ], $expected, "Test $i";
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#-------------------------------------------------------------------------------
sub get_expected
#-------------------------------------------------------------------------------
{
    my ($num) = @_;

    if    ($num == 1)
    {
        return  {
                    name   => 'id',
                    fields =>
                    [
                        [ field1 => 'value1' ],
                        [ field2 => 'value2' ],
                        [ field3 =>  42      ]
                    ]
                }
    }
    elsif ($num == 2)
    {
        return  {
                    name   =>  'youtube',
                    fields => [ [ title => 'Title "quoted" done' ] ]
                }
    }
    elsif ($num == 3)
    {
        return  {
                    name   =>  'youtube',
                    fields => [ [ title => 'Title with escaped backslash \\' ] ]
                }
    }
    elsif ($num == 4)
    {
        return  {
                    name => 'empty'
                }
    }
    elsif ($num == 5)
    {
        return;
    }
    elsif ($num == 6)
    {
        return  {
                      name   => 'id',
                      fields => [ [ filed1 => 'value1' ] ],
                }
    }

    die "The expected result for test $num is missing";
}

################################################################################

__DATA__
{%  id   field1="value1"    field2="value2"  field3=42 %}
{%  youtube title="Title \"quoted\" done" %}
{%  youtube title="Title with escaped backslash \\" %}
{%  empty %}
Non-record line
{% id  filed1="value1" %}
