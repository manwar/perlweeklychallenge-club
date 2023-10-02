#!/usr/bin/env raku

sub count-words(@arr,$pat)
{
  @arr.grep({/^$pat/}).elems
}

say count-words([qw/pay attention practice attend/],'at');
say count-words([qw/janet julia java javascript/],'ja');

