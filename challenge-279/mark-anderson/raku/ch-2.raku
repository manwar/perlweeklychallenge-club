#!/usr/bin/env raku
use HTTP::UserAgent;
use DOM::Tiny;
use Test;

nok split-string('perl'),                  '1 vowel';
ok  split-string('book'),                  '2 vowels';
ok  split-string('good morning'),          '4 vowels';
ok  split-string('anybody beyond mystic'), '8 vowels';

sub split-string($str is copy)
{
    $str .= lc;
    my $count = ($str ~~ m:g/ <[aeiou]> /).elems;

    for $str.words.grep({ .contains('y') }) -> $word
    {
        if $word.contains(none(<a e i o u>))
        {
            $count += ($word ~~ m:g/y/).elems;
            next
        }

        my $ua  = HTTP::UserAgent.new;
        my $res = $ua.get("https://www.merriam-webster.com/dictionary/$word");

        die $res.status-line unless $res.is-success; 

        my $dom = DOM::Tiny.parse($res.content);
        my @syllables = $dom.at('.word-syllables-entry')
                            .text.split("\x[00B7]\x[200B]");

        for @syllables
        {
            next unless .contains('y');
            $count += (.indices('y').grep(* > 0)).elems 
        }
    }

    return $count %% 2
}
