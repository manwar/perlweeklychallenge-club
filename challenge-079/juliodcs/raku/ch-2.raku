class WaterHistogram {
    subset Natural of UInt where * >= 1;

    constant \W_UNALIGNED_FOOTER = "WARNING: footer numbers may not be aligned\n";

    has Natural @!x-values;
    has Str $!lines;

    method !x-values is rw { @!x-values }
    method !lines is rw { $!lines }

    method new(*@list) {
        my $self = WaterHistogram.bless;
        $self!init: @list;
        $self
    }

    method print-it returns Nil {
        constant \MAX_SINGLE_DIGIT = 9;
        if self!max-value > MAX_SINGLE_DIGIT {
            $*ERR.say: W_UNALIGNED_FOOTER;
        }

        print self!lines;
        print self!separator;
        print self!footer;

        return;
    }

    method count-water returns UInt:D {
        # Counting water with Raku regex! Yay!
        elems self!lines ~~ m:g/｢  ｣ <after ｢#｣ ｢ ｣+> <before ｢ ｣* ｢#｣>/
    }

    method !separator returns Str:D {
        self!pad(｢-｣) ~ ｢ -｣ x self!x-values ~ "\n";
    }

    method !footer returns Str:D {
        self!pad(｢ ｣) ~ sprintf "[%s]\n", self!x-values.join: ｢ ｣
    }

    method !init(*@list) returns Nil {
        self!x-values = @list.map: *.Int;
        self!lines = self!prepare-lines;
        return;
    }

    method !prepare-lines returns Str:D {
        sub add-lines(Str:D $acc, Natural:D $line) {
            $acc ~ self!pad(~$line) ~ self!data-line($line) ~ "\n"
        }

        [[&add-lines]] ｢｣, self!max-value ... 1;
    }

    method !pad(Str:D $str) returns Str:D {
        sprintf "%{self!max-value.chars}s", $str;
    }

    method !data-line(Natural:D $line) returns Str:D {
        sub add-data-item(Str:D $acc, UInt:D $point-index) {
            $acc ~ self!data-item( $line, $point-index )
        }

        [[&add-data-item]] ｢｣, |^self!x-values.elems
    }

    method !data-item($line, $x-index) {
        $line <= self!x-values[$x-index] ?? ｢ #｣ !! ｢  ｣
    }

    method !max-value returns Natural:D {
        state Natural $max = self!x-values.max;
        $max
    }
}

sub MAIN(*@args) {
    say "\n";

    my $water-histogram = WaterHistogram.new: @args;

    $water-histogram.print-it;

    say "\nTotal water: " ~ $water-histogram.count-water;
}
