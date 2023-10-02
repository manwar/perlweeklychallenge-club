unit module benchmark-data-generator:ver<0.0.1>:auth<rcmlz@github.com)>;

my @problem-size-factor-ten = 1,10,100,1000,10000 ... Inf;
my @problem-size-factor-two = 1,2,4,8,16,32 ... Inf;
my Set $some-unicode-characters = 
                   ('a'..'z') ∪ ('A'..'Z') ∪ (0..9) ∪ 
                   ('∪', '∅', '∩', '⊖') ∪
                   ("\c[VULGAR FRACTION ONE HALF]", "\c[VULGAR FRACTION ONE SEVENTH]", "\c[VULGAR FRACTION ONE FIFTH]") ∪
                   ("\c[LATIN SMALL LETTER J WITH CARON, COMBINING DOT BELOW]", "\c[Roman Numeral Four]", "\c[Roman Numeral Three]", "\c[Roman Numeral Two]", "\c[Roman Numeral One]") ∪ 
                   ('à', 'è', 'ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß', "\c[LATIN CAPITAL LETTER SHARP S]") ∪ 
                   ("\c[PENGUIN]", "\c[BELL]", "\c[SMILING FACE WITH HALO]", "\c[GRINNING FACE]") ∪ 
                   ("\c[EGYPTIAN HIEROGLYPH A001]" .. "\c[EGYPTIAN HIEROGLYPH A004]");         

sub data-provider-for(Str $challenge, Str $task-string) is export {

    given $challenge => $task-string {
        when 'nr237' => 'task-one' { return pass } #&integers-from-subset.assuming(*, (5,10,20).Set, @problem-size-factor-two, log2(2**2).UInt)}
        when 'nr237' => 'task-two' { return &integers.assuming(*, -100, 100, @problem-size-factor-two, log2(2**5).UInt)}

        when 'nr236' => 'task-one' { return &integers-from-subset.assuming(*, (5,10,20).Set, @problem-size-factor-two, log2(2**2).UInt)}
        when 'nr236' => 'task-two' { return &integers-max-leq-problem-size.assuming(*, 0, @problem-size-factor-two, log2(2**2).UInt)}

        when 'nr235' => 'task-one' { return &strictly-increasing-integers-sequence.assuming(*, -1000000, 1000000, @problem-size-factor-two, log2(2**5).UInt)}
        when 'nr235' => 'task-one' { return &integers.assuming(*, -10, 10, @problem-size-factor-two, log2(2**5).UInt)}

        when 'nr234' => 'task-one' { return &unicode-words.assuming(*, 30, 5, 25, @problem-size-factor-two, log2(2**5).UInt)}
        when 'nr234' => 'task-two' { return &integers.assuming(*, 1, 3, @problem-size-factor-two, log2(2**5).UInt)}
        
        when 'nr233' => 'task-one' { return &unicode-words.assuming(*, 10, 1, 25, @problem-size-factor-two, log2(2**5).UInt) }
        when 'nr233' => 'task-two' { return &integers.assuming(*, -100, 100, @problem-size-factor-two, log2(2**5).UInt) }
        
        when 'DEMO' => 'task-one'  { return &data-task-template}
        when 'DEMO' => 'task-two'  { return &data-task-template}
        default {die "Data provider for $challenge $task-string not implemented."}
    }
}

sub unicode-words(UInt $entry, UInt $alphabet-size, UInt $min-length, UInt $max-length where {$min-length <= $max-length}, @sizes, UInt $size-offset) {
    
    my $n = @sizes[$entry + $size-offset];

    state @data;

    my $word-lenght = $min-length .. $max-length;
    state @alphabet = $some-unicode-characters.roll($alphabet-size);
    
    unless @data[$n] {
        @data[$n] = race for ^$n { @alphabet.roll($word-lenght.roll).join('').List };
    }
    return @data[$n];
}

sub strictly-increasing-integers-sequence(UInt $entry, Int $min, Int $max where {$min <= $max}, @sizes, UInt $size-offset = 0, $dropout-rate=0.2) {
    state @data is default([]);
    my $n = @sizes[$entry + $size-offset];
    @data[$n] = ($min..$max).pick($n).sort unless @data[$n].elems;
    return @data[$n];
}

sub integers-from-subset(UInt $entry, Set $numbers-to-use, @sizes, UInt $size-offset = 0) {
    state @data is default([]);
    my $n = @sizes[$entry + $size-offset];
    @data[$n] = $numbers-to-use.roll($n) unless @data[$n].elems;
    return @data[$n];
}

sub integers-max-leq-problem-size(UInt $entry, Int $min, @sizes, UInt $size-offset = 0) {
    state @data is default([]);
    my $n = @sizes[$entry + $size-offset];
    @data[$n] = ($min..$n).roll($n) unless @data[$n].elems;
    return @data[$n];
}

sub integers(UInt $entry, Int $min, Int $max where {$min <= $max}, @sizes, UInt $size-offset = 0) {
    state @data is default([]);
    my $n = @sizes[$entry + $size-offset];
    @data[$n] = ($min..$max).roll($n) unless @data[$n].elems;
    return @data[$n];
}

sub data-task-template(UInt $entry) {
    state @data is default([]);
    my $n = @problem-size-factor-ten[$entry];
    @data[$n] = 0..^$n unless @data[$n].elems;
    return @data[$n];
}
