#!/usr/bin/perl
use 5.038;
use warnings;
use Parse::RecDescent;

# $::RD_TRACE = 1;

my $grammar = <<'-EOT-';
    startrule: multi_line | single_line

    single_line: '{%' ws identifier field(s) '%}'
        {
            $return = "{\n"
                . "    name => $item{identifier},\n"
                . "    fields => {\n        "
                . join(",\n        ", @{$item{'field(s)'}})
                . "\n    }\n"
                . "}\n";
        }

    multi_line: '{%' ws identifier field(s) '%}' text '{%' ws "endmyid" ws '%}'
        {
            $return = "{\n"
                . "    name => $item{identifier},\n"
                . "    fields => {\n        "
                . join(",\n        ", @{$item{'field(s)'}})
                . "\n    },\n"
                . "    text => $item{text}"
                . "}\n";
        }

    ws: /\s*/

    identifier: /\w+/
    {
        my $id = $item[1];
        $return = $id;
    }

    field: ws name ws '=' ws value
        { $return = "$item{ name } => $item{ value }"  }

    name: /\w+/

    value: number | string

    number: /\d+/
        { $return = 0 + $item[1]; }

    string: /"/ content /"/
        { $return = $item{content}; }

    content: /(\\" | \\\\ | [^"])+/x

    text: /[^{]+/
-EOT-

my $parser = Parse::RecDescent->new($grammar);
my $text = shift;
say $parser->startrule($text);
