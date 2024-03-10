#!/usr/bin/env raku

grammar LineParser {
    rule TOP  { <.ws>  <tag>[ <lines> {} <endtag($<tag><id>)>]? }

    rule tag { '{%' ~ '%}' [ <id> <field> *] }

    token id { \w+ }
    rule field { <name> '=' <value>  }
    token name  { \w+ }
    token value { \d+ | '"' ~  '"'  <value-string> } #"
    token value-string { [<-["]> | '\"' | '\\']* }

    token lines { [<!before '{%'>.]* }
    rule endtag($id) { '{%' ~ '%}' ['end'$id] }
}

class LineAction {
    method TOP   ($/) { make  %(|$<tag>.made, |$<lines>.made ) }
    method tag   ($/) { make  %( name => ~$<id>, fields => %( $<field>».made ) ) }
    method field ($/) { make ~$<name> => $<value>.made }
    method value ($/) { make  $<value-string>.made // +$/ }
    method value-string ($/) { make  ~$/ }
    method lines ($/) { make (text => ~$/.trim)  }
}

sub line-parser ($string) {
    LineParser.parse( $string, actions => LineAction.new)
    andthen .made
}

multi MAIN (Bool :test($)!) {
    use Test;

    is LineParser.parse( 'field1 = "value1"', :rule<field>).<name>, 'field1';
    is LineParser.parse( 'field1="value1"', :rule<field>).<value><value-string>, 'value1';
    is LineParser.parse( 'field1 = 12', :rule<field>).<value>, 12;
    is LineParser.parse('\"quoted\"', :rule<value-string> ), '\"quoted\"';
    is LineParser.parse('Title \"quoted\" done', :rule<value-string> ).so, True;
    is LineParser.parse('abab {a', :rule<lines> ).so, True;
    is LineParser.parse('abab {%', :rule<lines> ).so, False;
    is LineParser.parse('{% endid %}',:rule<endtag>,:args('id',) ).so, True;
    is LineParser.parse('{% id %} Text {% endid %}', ).<lines>, 'Text ';
    is LineParser.parse('{% tag %} Text {% endtag %}', ).<tag><id>, 'tag';
    is LineParser.parse('{%  id   field1="value1"    field2="value2"  field3=42 %}')<tag><field>»<name>,
    <field1 field2 field3>;
    is LineParser.parse('{%  youtube title="Title \"quoted\" done" %}')<tag><id>, 'youtube';

    is-deeply LineParser.parse( 'field1 = "value1"', :rule<field>, actions => LineAction.new).made, (field1 => 'value1');
    is-deeply LineParser.parse( 'field1 = 12', :rule<field>, actions => LineAction.new).made, (field1 => 12);

    my %parsed := %(
       name => 'id',
       fields => {
           field1 => 'value1',
           field2 => 'value2',
           field3 => 42,
       },
       text => 'LINES'
    );
    is-deeply line-parser('{% id t=1 tit="a" %} Text {% endid %}'), %(:fields(%(:t(1), :tit("a"))), :name("id"), :text("Text"));
    is-deeply line-parser('
          {%  id   field1="value1"    field2="value2"  field3=42 %}
          LINES
          {% endid %}
    '), %parsed;
    done-testing;
}

multi MAIN ($string) {
    say line-parser $string
}
