#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 259 Task 2 Line Parser
#=============================================================================
# You are given a line like below:
# {%  id   field1="value1"    field2="value2"  field3=42 %}
# Where
#   a) "id" can be \w+.
#   b) There can be 0  or more field-value pairs.
#   c) The name of the fields are \w+.
#   b) The values are either number in which case we don't need double
#      quotes or string in which case we need double quotes around them.
# The line parser should return structure like below:
# {
#      name => id,
#      fields => {
#          field1 => value1,
#          field2 => value2,
#          field3 => value3,
#      }
# }
# It should be able to parse the following edge cases too:
# {%  youtube title="Title \"quoted\" done" %}
# and
# {%  youtube title="Title with escaped backslash \\" %}
# BONUS: Extend it to be able to handle multiline tags:
# {% id  field1="value1" ... %}
# LINES
# {% endid %}
#
# You should expect the following structure from your line parser:
# {
#      name => id,
#      fields => {
#          field1 => value1,
#          field2 => value2,
#          field3 => value3,
#      }
#      text => LINES
# }
#=============================================================================

use v5.38;

use builtin qw/true false trim/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

use Text::Balanced qw/extract_quotelike/;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub parse($input)
{
    my %record;
    my ($id, $fields) = ($input =~ m/{%\s+(\w+)\s+(.*)\s*%}/);
    $record{name} = $id;

    while ( $fields =~ m/(\w+)=("?[^"\\]*(\\.[^"\\]*)*"?)/g )
    {
        my $k = trim($1);
        my $v = trim($2);
        $v =~ s/\A["[:space:]]+|["[:space:]]+\z//g;

        $v =~ s/\\"/"/g;
        $v =~ s/\\\\/\\/g;

        say "[$k]=[$v]" if $Verbose;
        $record{fields}{$k} = $v;
    }

    if ( $input =~ m/{%\s+end$id\s+%}/ )
    {
        for ( split(/^/, $input) )
        {
            my $rc;
            $record{text} .= $_ 
                if $rc = /%}/ ... /{%\s+end$id\s+%}/
                    and $rc !~ /(^1|E0)$/;
        }
    }
    return \%record;
}

sub runTest
{
    use Test2::V0;

    is( parse( q/{%  id   field1="value1"    field2="value2"  field3=42 %}/ ),
        { name => "id",
            fields => {
                field1 => "value1",
                field2 => "value2",
                field3 => 42,
            }
        },
        "Example 1");

    is( parse( q/{%  youtube title="Title \"quoted\" done" %}/ ),
            {
                name => "youtube",
                fields => {
                    title => qq(Title "quoted" done),
                }
            },
            "Example 2");

    is( parse( q/{%  youtube title="Title with escaped backslash \\\\" %}/ ),
            {
                name => "youtube",
                fields => {
                    title => q/Title with escaped backslash \\/
                }
            },
            "Example 3");
    
    my $input = <<'_INPUT_';
{% bonus k="v" %}
Here's some block
paragraph text.
{% endbonus %}
_INPUT_

    is( parse($input),
            {
                name => "bonus",
                fields => { k => "v" },
                text => "Here's some block\nparagraph text.\n"
            },
        "Bonus test");

    done_testing;
}
