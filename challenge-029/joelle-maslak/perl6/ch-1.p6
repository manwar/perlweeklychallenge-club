#!/usr/bin/env perl6
use v6;

# This handles the following:
#
#   a{1,2}
#   a{1,2{3,4}}{5,6}b
# 
# And similar versions.  So, yes, you can nest and have multiple
# curlies. Note there is no way to "quote" commas or curlies at this
# time, but they would be reasonably straightforward to add (Perl 6 is
# awesome).  Now to try to figure out how to do this in P5, without the
# awesome grammars...
#

grammar Expansion {
    rule TOP      {
        ^
        <element>*
        $
    }
    token element  { <string> | <curly> }
    token string   { <-[ \{ \} ]>+ }
    token curly    { \{ <option>+ % ',' \} }
    token option   { <innerele>* }
    token innerele { <innerstr> | <curly> }
    token innerstr { <-[ \{ \} \, ]>+ }
}


sub MAIN(Str:D $str) {
    my $expanded = expand($str);

    say $expanded.sort.unique.join("\n");
}

sub expand($str) {
    my $parse = Expansion.parse($str);
    die "Invalid String" unless $parse.defined;

    return expansion([''], $parse);
}

# The magic happens here.  Basically it recursively calls itself as it
# descends the tree.  Have I mentioned how much I love Perl 6 grammars?
#
# Note that string token is different than the innerstr, which looks
# like duplicated code (I'm willing to live with a few lines here)
# but is not quite since string and innerstring *are* different - the
# outter strings (outside any curlies) allows commas.
sub expansion(@arr is copy, $tree) {
    if $tree<element>:exists {
        # Handle each element.
        for @($tree<element>) -> $ele {
            @arr = expansion(@arr, $ele);
        }
        return @arr;
    } elsif $tree<innerele>:exists {
        for @($tree<innerele>) -> $ele {
            @arr = expansion(@arr, $ele);
        }
        return @arr;
    } elsif $tree<string>:exists {
        return @arr.map: { $_ ~ $tree<string> };
    } elsif $tree<innerstr>:exists {
        return @arr.map: { $_ ~ $tree<innerstr> };
    } elsif $tree<curly>:exists {
        my @arr-copy = @arr;
        @arr = [];
        for @($tree<curly><option>) -> $ele {
            @arr.append: expansion(@arr-copy, $ele);
        }
        return @arr;
    } else {
        die;
    }

}

