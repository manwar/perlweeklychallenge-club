#!/usr/bin/env raku

say parse-line('{%  id   field1="value1"    field2="value2"  field3=42 %}'); 
say parse-line('{%  youtube title="Title \"quoted\" done" %}');
say parse-line('{%  youtube title="Title with escaped backslash \\" %}');

grammar Ch2
{
    rule  TOP      { '{%' <ID> <KeyVal>* '%}'                       }
    token ID       { \w+                                            } 
    token Key      { \w+                                            }
    token Quoted   { '\"' <[\w\s]>+ '\"'                            } 
    token Unquoted { <[\w\s]>+                                      } 
    token Val      { '"' [<Quoted>||<Unquoted>|| '\\' ]+ '"' || \d+ }
    rule  KeyVal   { <Key> '=' <Val>                                }      
}

sub parse-line($s)
{
    my %h;
    my %fields;
    my $m = Ch2.parse($s);

    %h<name> = ~$m<ID>;
    %fields{~.<Key>} = ~.<Val> for $m<KeyVal>; 
    %h<fields> = %fields;

    return %h
}
