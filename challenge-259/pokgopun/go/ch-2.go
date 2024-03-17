//# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/
/*#

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
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"reflect"
	"regexp"
	"strconv"
)

type kvpair map[string]string

type parsed struct {
	name, text string
	fields     kvpair
}

type parser struct {
	m              []string
	rgxLine, rgxKV *regexp.Regexp
}

func newParser() parser {
	return parser{
		rgxLine: regexp.MustCompile(`{%\s(?P<name>\w+)(?P<kv>(?:\s\w+=(?:\d+|"(?:\\(?:"|\\)|[^"\\])+?"))+)?\s%}(?:\n(?P<tag>[\d\D]+?)\n\{%\sendid\s%})?`),
		rgxKV:   regexp.MustCompile(`\s(?P<key>\w+)=(?P<value>\d+|"(?:\\(?:"|\\)|[^"\\])+?")`),
	}
}

func (ps parser) parse(msg string) parsed {
	ps.m = ps.rgxLine.FindStringSubmatch(msg)
	p := parsed{name: ps.m[1], text: ps.m[3], fields: make(kvpair)}
	if ps.m[2] != "" {
		for _, kv := range ps.rgxKV.FindAllStringSubmatch(ps.m[2], -1) {
			_, err := strconv.Atoi(kv[2])
			if err != nil {
				kv[2], _ = strconv.Unquote(kv[2])
			}
			p.fields[kv[1]] = kv[2]
		}
	}
	return p
}

func main() {
	p := newParser()
	for _, data := range []struct {
		input  string
		output parsed
	}{
		{
			`{% youtube id=1234 title="Title \"quoted\" done" %}`,
			parsed{
				name: "youtube",
				fields: kvpair{
					"id":    "1234",
					"title": `Title "quoted" done`,
				},
			},
		},
		{
			`{% youtube title="Title with escaped backslash \\" id=4321 %}`,
			parsed{
				name: "youtube",
				fields: kvpair{
					"id":    "4321",
					"title": `Title with escaped backslash \`,
				},
			},
		},
		{
			`{% id %}`,
			parsed{name: "id", fields: kvpair{}},
		},
		{
			`{% youtube id=12345 title="mejoo and cats" cats="\"monji\" \\ \"bongji\" \\ \"hyuji\" \\ \"yoji\" \\ \"audrey\"" %}
soo
mejoo
{% endid %}`,
			parsed{
				name: "youtube",
				fields: kvpair{
					"id":    "12345",
					"cats":  `"monji" \ "bongji" \ "hyuji" \ "yoji" \ "audrey"`,
					"title": "mejoo and cats",
				},
				text: `soo
mejoo`,
			},
		},
	} {
		//fmt.Println(p.parse(data.input))
		fmt.Println(reflect.DeepEqual(p.parse(data.input), data.output))
	}
}
