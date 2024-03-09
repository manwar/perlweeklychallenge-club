#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/#TASK2
#
# Task 2: Line Parser
# ===================
#
# You are given a line like below:
#
# {%  id   field1="value1"    field2="value2"  field3=42 %}
#
# Where
#
# a) "id" can be \w+.
# b) There can be 0  or more field-value pairs.
# c) The name of the fields are \w+.
# b) The values are either number in which case we don't need double quotes or
#    string in which case we need double quotes around them.
#
# The line parser should return structure like below:
#
# {
#        name => id,
#        fields => {
#            field1 => value1,
#            field2 => value2,
#            field3 => value3,
#        }
# }
#
# It should be able to parse the following edge cases too:
#
# {%  youtube title="Title \"quoted\" done" %}
#
# and
#
# {%  youtube title="Title with escaped backslash \\" %}
#
# BONUS: Extend it to be able to handle multiline tags:
#
# {% id  filed1="value1" ... %}
# LINES
# {% endid %}
#
# You should expect the following structure from your line parser:
#
# {
#        name => id,
#        fields => {
#            field1 => value1,
#            field2 => value2,
#            field3 => value3,
#        }
#        text => LINES
# }
#
############################################################
##
## discussion
##
############################################################
#
# Parsers are always a bit complicated, so most solutions to
# this problem will probably be as well.
# There might also always be some corner cases that are not
# clear right away. In this case the description says:
#    The values are either number in which case we don't need
#    double quotes or string in which case we need double quotes
#    around them.
# It remains unclear whether or not this includes floating point
# numbers or only integers, so I decided to at least also support
# decimal number written with a single "." like 12.34, but not
# the full list of possible representations of floats like 1E5 or
# similar stuff.
# A full parser usually needs to split everything into tokens which
# can then be processed one by one, and regular expressions are not
# enough to build a full parser in most cases. In our case, I used
# a mixed approach: handle everything with regular expressions
# that is easy to handle that way. However, parsing strings is done
# by handing in the rest of the current line into a function that
# will then return the string at the beginning of the line and the
# remainder of the input once the string is removed. This function
# parses the rest of the line one character at a time, no regular
# expressions there. The loop that calls this function goes line
# at a time, always picking up larger chunks of the line by using
# regular expressions. This outer loop makes use of the Switch
# module unnecessarily as my first intention was to implement a
# full character-by-character parser which would have required
# some kind of a state machine to always know where in the parsing
# process we are at any time, but then I decided to try an
# approach making use of regular expressions, so a single variable
# could have taken care of everything (Just keep the sectionname
# in a variable, and if empty assume we're in the default state
# and take it from there), but then I wouldn't have had the
# opportunity to try out the Switch module, so I kept the code as
# it was.

use strict;
use warnings;
use Switch;
use Data::Dumper;

my $DEFAULT = 'Default';
my $INSECTION = 'InSection';
my $SECTIONNAME = "";

my @ALL_DATA; # the result will be stored here
my $CURRENT_DATA = {}; # for temporarily storing the data we're currently parsing
my $state = $DEFAULT; # initialize the state machine

my $input = <<EOF;
{%  id   field1="value1"    field2="value2"  field3=42 %}
{%  endid %}
Some random data somewhere in between
{%  youtube title="Title \\"quoted\\" done" %}
{% endyoutube %}
{%  youtube title="Title with escaped backslash \\\\" %}
Some data
More data
{% endyoutube %}
{%  id   field1="value1"    field2="value2"  field3=42.32 field4="Hello, world!" %}
{%  endid %}
{%  foo %}
Bar.
{%  endfoo %}
EOF
my @lines = split /\n/, $input;

foreach my $line (@lines) {
   switch($state) {
      case "$DEFAULT" {
         # not inside a section, so we expect either the begin of a new section
         # or a plain string to ingest
         if($line =~ m/^\s*\{\%\s*(\w+)/) { # new section starts
            # keep name of section and switch to correct state
            $SECTIONNAME = $1;
            $state = $INSECTION;
            # remove start of line including the section name
            $line =~ s/\s*\{\%\s*$SECTIONNAME\s+//;
            # initialize temporary data structure's name
            $CURRENT_DATA->{name} = $SECTIONNAME;
            while(length($line) > 0) { # ingest rest of line
               # remove unnecessary whitespace
               $line =~ s/^\s+//;
               if($line =~ m/^\s*\%\}\s*$/) {
                  # we found the end of the line, let's just set everything
                  # into a state that will break out of the loop.
                  $line = "";
               } else {
                  # now we have a new field at the beginning of the line, so
                  # we remove (and capture) the field name
                  $line =~ s/^(\w+)=//;
                  my $key = $1;
                  if($line =~ m/^(\d+)(\.\d+){0,1}(\s|\%\})/) {
                     # number at beginning of line, remove it and
                     # capture it in the temporary data structure
                     $line =~ s/^(\d+(\.\d+){0,1})//;
                     $CURRENT_DATA->{fields}->{$key} = $1;
                  } elsif ( $line =~ m/^"/ ) {
                     # string at the beginning of the line, let's hand the
                     # function into the parser function for this case, then
                     # store the resulting string into the temporary data
                     # structure, keeping the remainder in $line for further
                     # processing in the next iteration of the loop
                     my $string;
                     ($string, $line) = parse_next_string($line);
                     $CURRENT_DATA->{fields}->{$key} = $string;
                  } else {
                     die "Parse error, value neither number nor string here ->$line!";
                  }
               }
            }
         } else { # plain string to ingest
            push @ALL_DATA, $line;
         }
      }
      case "$INSECTION" {
         # either we find the end of the current section, or we copy the line as-is
         # to the text inside our data structure
         if($line =~ m/^\s*\{\%\s*end$SECTIONNAME\s*\%\}\s*$/) {
            # end of section: store current temporary data into the result,
            # reset the temporary data structure and switch back to the default
            # state
            push @ALL_DATA, $CURRENT_DATA;
            $CURRENT_DATA = {};
            $state = $DEFAULT;
         } else {
            $CURRENT_DATA->{text} .= "$line\n";
         }
      }
      else { die "Unknown state $state!\n"; }
   }
}
foreach my $entry (@ALL_DATA) {
   print Dumper $entry;
}

# given the rest of a line, split this into the string at the beginning
# of the line and the remainder of the line after removing this string
sub parse_next_string {
   my $input = shift;
   my @chars = split //, $input;
   my ($string, $rest) = ("", "");
   die "Not a string" unless $chars[0] eq '"';
   my $index = 1;
   while($index <= $#chars) {
      if($chars[$index] eq '"') { # closing '"', finish everything up
         $rest = substr($input, $index+1);
         return ($string, $rest);
      } elsif ($chars[$index] eq "\\") {
         # if we find a '\', we just ingest the next character as is.
         # This means '\\' turns into a single '\', '\"' turns into
         # a single '"', and other stuff like '\a' turns into 'a'.
         # No need to make things more complicated in this case.
         $index++;
         $string .= $chars[$index];
      } else {
         # everything apart from '\' or '"' just indicates a character
         # to be ingested as-is.
         $string .= $chars[$index];
      }
      $index++;
   }
   # if we end up here, there was no matching '"'
   # so we ran into a parsing error
   die "Parser error: Could not find closing '\"' in $input";
}
