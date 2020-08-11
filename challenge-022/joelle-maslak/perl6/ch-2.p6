#!/usr/bin/env perl6
use v6.d;

class Dictionary {
    has %!dict;
    has %!index;
    has UInt:D $!next = 0;
    has UInt:D $.bits where * ≥ 8;

    method lookup(buf8:D $val -->UInt) {
        my $key = $val.join(":");
        return %!dict{$key} if %!dict{$key}:exists;

        return UInt;
    }

    method index(UInt:D $index -->buf8) {
        return buf8 unless %!index{$index}:exists;
        return %!index{$index};
    }

    method store(buf8:D $val -->UInt) {
        my $key = $val.join(":");
        return self.lookup($val) if self.lookup($val).defined;
        return UInt if $!next ≥ 2**$.bits;

        %!dict{$key}    = $!next;
        %!index{$!next} = $val;

        $!next++;

        return %!dict{$key};
    }

    method TWEAK() {
        for ^256 -> $i {
            my $buf = buf8.new($i);
            self.store($buf);
        }
    }
}

# Write bits out in MSB first format
class Bitwise-Write {
    has Str  $.filename is required;
    has UInt $.bits is required;

    has $!fh;
    has UInt:D $!pending = 0;
    has UInt:D $!pending-bits = 0;

    method TWEAK() {
        $!fh = $.filename.IO.open: :w, :bin;
    }

    method write(UInt:D $val is copy) {
        my $bits = $.bits;

        $val  += $!pending +< $bits;
        $bits += $!pending-bits;

        while $bits ≥ 8 {
            my $tmp = ( $val +> ($bits - 8) ) % 2⁸;
            $!fh.write(buf8.new($tmp));
            $bits -= 8;
        }

        $!pending = ( ( $val +< (8 - $bits) ) % 2⁸ ) +> (8 - $bits);
        $!pending-bits = $bits;
    }

    method close() {
        if $!pending-bits > 0 {
            $!fh.write(buf8.new( $!pending +< (8 - $!pending-bits) ));
        }
        $!fh.close;
    }
}

# Read UInts out in MSB first format
class Bitwise-Read {
    has Str  $.filename is required;
    has UInt $.bits is required;

    has $!fh;
    has UInt:D $!pending = 0;
    has UInt:D $!pending-bits = 0;

    method TWEAK() {
        $!fh = $.filename.IO.open: :r, :bin;
    }

    method read(-->UInt) {
        my $val  = $!pending;
        my $bits = $!pending-bits;

        while $bits < $!bits {
            my $c = $!fh.read(1);
            return UInt unless $c.elems;

            $val   = $val +< 8;
            $val  += $c[0];
            $bits += 8;
        }

        $!pending-bits = $bits - $!bits;
        my $out        = $val +> $!pending-bits;
        $!pending      = $val - ($out +< $!pending-bits);

        return $out;
    }

    method close() {
        $!fh.close;
    }
}

multi sub MAIN(
    "compress",
    Str:D  :$infile,
    Str:D  :$outfile,
    UInt:D :$bits where * ≥ 8 = 12,
) {
    # Initialize the dictionary
    my $dict = Dictionary.new(:$bits);

    my $in  = $infile.IO.open: :r, :bin;
    my $out = Bitwise-Write.new(:filename($outfile), :$bits);

    my $buf = buf8.new;
    while $in.read(1) -> $c {
       $buf.push: $c;
       next if $dict.lookup($buf);

       # Okay, we don't have the string - how much do we write out?
       $dict.store: $buf;  # First we store this for future use.

       # Now we write up what we can lookup
       $buf.pop;
       $out.write: $dict.lookup($buf);

       # Now we reset the buffer
       $buf = buf8.new($c);
    }

    # Flush pending buffered characters (if any)
    $out.write($dict.lookup($buf)) if $buf.elems;

    $in.close;
    $out.close;
}

multi sub MAIN(
    "decompress",
    Str:D  :$infile,
    Str:D  :$outfile,
    UInt:D :$bits where * ≥ 8 = 12,
) {
    # Initialize the dictionary
    my $dict = Dictionary.new(:$bits);

    my $in  = Bitwise-Read.new(:filename($infile), :$bits);
    my $out = $outfile.IO.open: :w, :bin;

    my $prevbuf = buf8.new;
    while (my $value = $in.read()).defined {
        my $buf = $dict.index($value);
        if ! defined($buf) {
            $buf = $prevbuf;
            $buf.push: $buf[0];
            $dict.store: $buf;
        } else {
            if $prevbuf.elems {
                $prevbuf.push: $buf[0];
                $dict.store($prevbuf);
            }
        }
        $out.write: $buf;
        $prevbuf = buf8.new: $buf;
    }

    $in.close;
    $out.close;
}

