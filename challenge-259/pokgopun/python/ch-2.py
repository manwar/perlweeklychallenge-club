### https://theweeklychallenge.org/blog/perl-weekly-challenge-259/
"""

Task 2: Line Parser

Submitted by: [43]Gabor Szabo
     __________________________________________________________________

   You are given a line like below:
{%  id   field1="value1"    field2="value2"  field3=42 %}

   Where
a) "id" can be \w+.
b) There can be 0  or more field-value pairs.
c) The name of the fields are \w+.
b) The values are either number in which case we don't need parentheses or strin
g in
   which case we need parentheses around them.

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
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 10th March
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

import re

rgxLine = re.compile(r'{%\s(?P<name>\w+)(?P<kv>(?:\s\w+=(?:\d+|"(?:\\(?:"|\\)|[^"\\])+?"))+)?\s%}(?:\n(?P<tag>[\d\D]+?)\n\{%\sendid\s%})?')
rgxKV = re.compile(r'\s(?P<key>\w+)=(?P<value>\d+|"(?:\\(?:"|\\)|[^"\\])+?")')
 
def lineParser(msg: str):
    res = rgxLine.match(msg)
    parsed = { "name": res.group("name") }
    resKV = res.group("kv")
    if resKV is not None:
        parsed["fields"] = {}
        for resKV in rgxKV.finditer(res.group("kv")):
            k = resKV.group("key")
            v = resKV.group("value")
            if v.isnumeric():
                v = int(v)
            else:
                v = v[1:-1].encode("utf-8").decode('unicode_escape')
            parsed["fields"][k] = v
    tag = res.group("tag")
    if tag is not None:
        parsed["text"] = tag
    return parsed

import unittest

class TestLineParser(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                r'{% youtube id=1234 title="Title \"quoted\" done" %}': {
                    'name': 'youtube',
                    'fields': {
                        'id': 1234,
                        'title': 'Title "quoted" done',
                        },
                    },
                r'{% youtube title="Title with escaped backslash \\" id=4321 %}': {
                    'name': 'youtube',
                    'fields': {
                        'id': 4321,
                        'title': 'Title with escaped backslash \\',
                        },
                    },
                r'''{% id field1="value1" field2=1324 %}
LINE1
LINE2
{% endid %}''': {
    'name': 'id',
    'fields': {
        'field2': 1324,
        'field1': 'value1',
        },
    'text': '''LINE1
LINE2''',
},
}.items():
            self.assertEqual(lineParser(inpt),otpt)

unittest.main()
