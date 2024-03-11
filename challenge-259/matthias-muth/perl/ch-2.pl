#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 259 Task 2: Line Parser
#
#       Perl solution by Matthias Muth.
#

use v5.36;

my $id_re          = qr/ (?<id>    \w+ ) /x;
my $number_re      = qr/ (?<value> \d+ ) /x;
my $quoted_text_re = qr/ " (?<value> (?: \\\\ | \\" | [^"] )* ) " /x;
my $value_re       = qr/ ${number_re} | ${quoted_text_re} /x;
my $structure_re   = qr/
        {% \s* (?<name> $id_re )
            (?<fields> (?: \s* $id_re = $value_re )* )
        \s* %}
        (?: \s* (?<text> (?: (?! {% ) . )*? )
            \s* {% \s* end\g{name} \s* %} )?
    /xs;

sub line_parser( $text ) {
    $text =~ /$structure_re/
        or return;
    my %structure = ( name => $+{name} );
    $structure{text} = $+{text}
        if defined $+{text};
    my $fields = $+{fields};
    while ( $fields =~ /$id_re=$value_re/g ) {
        my ( $id, $value ) = @+{ qw( id value ) };
        # Revert quoted backslashes or double quotes.
        $value =~ s/\\([\\"])/$1/g;
        $structure{fields}{$id} = $value;
    }
    return \%structure;
}

use Test2::V0 -no_srand => 1;
is line_parser( '{%  id   field1="value1"    field2="value2"  field3=42 %}' ),
    {
      name => "id",
      fields => {
          field1 => "value1",
          field2 => "value2",
          field3 => 42
      },
    },
    "Example 1";
is line_parser( '{%  youtube title="Title \"quoted\" done" %}' ),
    {
      name => "youtube",
      fields => {
          title => "Title \"quoted\" done",
      },
    },
    "Example 2";
is line_parser( '{%  youtube title="Title with escaped backslash \\" %}' ),
    {
      name => "youtube",
      fields => {
          title => "Title with escaped backslash \\",
      },
    },
    "Example 3";
is line_parser( "{% id  filed1=\"value1\" %}\nLINES\n{% endid %}" ),
    {
      name => "id",
      fields => {
          filed1 => "value1",
      },
      text => "LINES",
    },
    "Multiline example";
done_testing;
