sub last-word($string, $regexp) 
{
    $string.words.grep( $regexp ).tail;
}

say last-word('  hello world', rx/ <[ea]> l /);                # 'hello'
say last-word("Don't match too much, Chet!",  rx:i/ ch . t /); # 'Chet!'
say last-word("spaces in regexp won't match", rx/ \s re /);    #  undef
