#!/bin/env raku

grammar Line {
    rule  TOP   { '{%' <Name> <Field>* '%}' [<Text> '{%' 'endid' '%}']? }
    token Name  { \w+ }
    rule  Field { <Name> '=' <Value> }
    rule  Value { \d+ || '"' <Chars> '"' }
    token Chars { ["\\\\" | '\"' | <-["]>]+ }
    rule  Text  { .+? }
}

class LineActions {
    method TOP($/) {
        make (
            :name($<Name>.made),
            :fields(($<Field>».made).Hash),
            (:text($<Text>.made) with $<Text>)
        ).Hash
    }
    method Name($/)  { make ~$/ }
    method Field($/) { make $<Name>.made => $<Value>.made }
    method Value($/) {
        with $<Chars> {
            make $<Chars>.made
        } else {
            make +$/
        }
    }
    method Chars($/) { make ~$/ }
    method Text($/)  { make (~$/).trim }
}

multi sub MAIN('test') {
    use Test;

    is Line.parse('abc', :rule<Chars>, :actions(LineActions)).made, 'abc', '"abc" parsed as Chars';
    is Line.parse('ab c ', :rule<Chars>, :actions(LineActions)).made, 'ab c ', '"ab c " parsed as Chars';
    is Line.parse('ab \"c ', :rule<Chars>, :actions(LineActions)).made, 'ab \"c ', '"ab \"c " parsed as Chars';

    is-deeply Line.parse('{% id field1="value1" field2="value2" field3=42 %}', :actions(LineActions)).made,
        (:name("id"), :fields((:field1("value1"), :field2("value2"), :field3(42)).Hash)).Hash,
        q/{% id field1="value1" field2="value2" field3=42 %} => {name => id, fields => {field1 => value1, field2 => value2, field3 => 42}}/;

    is-deeply Line.parse('{% youtube title="Title \"quoted\" done" %}', :actions(LineActions)).made,
        (:name("youtube"), :fields((:title("Title \\\"quoted\\\" done")).Hash)).Hash,
        q/{% youtube title="Title \"quoted\" done" %} => {name => youtube, fields => {title => Title \"quoted\" done}}/;

    my $s = q:to/END/;
        {% id field1="value1" field2="value2" %}
        LINES
        {% endid %}
        END
    is-deeply Line.parse($s, :actions(LineActions)).made,
        (:name("id"), :fields((:field1("value1"), :field2("value2")).Hash), :text("LINES")).Hash,
        "... => \{name => id, fields => \{field1 => value1, field2 => value2\}, text => LINES\}";

    done-testing;
}

multi sub MAIN(Str:D $line) {
    put Line.parse($line, :actions(LineActions)).made.gist;
}
