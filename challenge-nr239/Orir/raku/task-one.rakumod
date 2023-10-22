unit module Orir::raku::task-one:ver<0.0.1>:auth<github:Orir>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/Orir/raku/ -- test/challenge-nr239/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-one --user=Orir --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
	by-chunks(@input[0], @input[1])
}

sub join-eq( @a, @b ) {
    when @a.join eq @b.join { True }
    False
}

class Iter-by-buf {       # put in caller while not a proper iter
    has @.a           is required;
    has UInt $.bufsiz is required;
    has UInt $.idx    is rw = 0;
    has UInt $.pos    is rw = 0;
    has $.done              = "";

    #  Return the next $.bufsiz Chars @.a or a smaller tail.
    method next( --> Str) {
        my $want = $.bufsiz;
        my $ret;
        loop {
            if not @.a[$.idx] :exists {     # do last or done 
                return $.done without $ret;
                return $ret;
            }
            if @.a[$.idx] eq "" {           # skip empty Str elems
                ++ $.idx;
                next;
            }
            if @.a[$.idx].chars - $.pos > $want {   # want from current elem
                $ret ~= @.a[$.idx].substr: $.pos..^($.pos + $want);
                $.pos += $want;
                return $ret;
            }
            if @.a[$.idx].chars - $.pos < $want {  # partial want from current
                my $tmp = @.a[$.idx].substr: $.pos;
                $want -= $tmp.chars;
                ++ $.idx;
                $.pos = 0;
                $ret ~= $tmp;
                next;
            }
            # fallthrough to the default odd case
           $ret ~= @.a[$.idx].substr: $.pos; # want consumes balance of current
           ++$.idx;
           $.pos = 0;
           return $ret;
        }
        die "REACHED: Stupid programmer put this here.";
    }
} # class Iter-by-buf

sub by-chunks( @a, @b, $char-ct = 3) {
    my $a-iter = Iter-by-buf.new: bufsiz => $char-ct, a => @a;
    my $b-iter = Iter-by-buf.new: bufsiz => $char-ct, a => @b;  # loop here?

    loop {
        when $a-iter.next ne $b-iter.next {
            return False
        }
        when $a-iter.next eq (my $b = $b-iter.next) {
            return True if $b eq  $b-iter.done;
            next
        }
    }
    die "REACHED: Programmer not sufficiently competent!"

}