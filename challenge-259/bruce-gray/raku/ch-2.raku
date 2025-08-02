grammar Task2_Record {
    rule  TOP         { ^ '{%' <id> <field>* '%}' $ }
    rule  field       { <field_name> '=' <field_value> }
    token id          { \w+ }
    token field_name  { \w+ }
    token field_value { <number> | <string> }
    token number      { \d+ }

    # From https://andrewshitov.com/2020/03/29/chapter-6-working-with-strings/
    token string {
        '"' ( [
              | <-["\\]>+
              | '\\"'
              | '\\\\'
              ]* )
        '"'
    }
}
class Task2_Actions {
    method TOP ($/) {
        $/.make: {
            name   => ~$/<id>,
            fields => $/<field>».made.Hash,
        };
    }
    method field       ($/) { $/.make: ~$/<field_name> => $/<field_value>.made }
    method field_value ($/) { $/.make: ( $/<number> // $/<string> ).made }
    method string      ($/) { $/.make: ~$/[0] }
    method number      ($/) { $/.make: +$/ }
}
sub task2 ( Str $s ) {
    my $p = Task2_Record.parse($s, :actions(Task2_Actions))
        orelse die;
    return $p.made;
}


# No time for the Bonus this week.
my @tests = 
    ｢{%  id   field1="value1"    field2="value2"  field3=42 %}｣,
    ｢{%  youtube title="Title \"quoted\" done" %}｣,
    ｢{%  youtube title="Title with escaped backslash \\" %}｣,
;
my @expected =
    { name => 'id'      , fields => { field1 => 'value1', field2 => 'value2', field3 => 42 } },
    { name => 'youtube' , fields => { title => 'Title \"quoted\" done' }, },
    { name => 'youtube' , fields => { title => ｢Title with escaped backslash \\｣ }, },
;
use Test; plan +@tests;
for @tests Z @expected -> (Str $in, %exp) {
    is-deeply task2($in), %exp;
}
