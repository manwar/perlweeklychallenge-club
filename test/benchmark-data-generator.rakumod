unit module benchmark-data-generator:ver<0.0.1>:auth<rcmlz@github.com)>;

sub data-provider-for($challenge, Str $task-string) is export {
    return &random-strings if ('nr233', 'task-one') ~~ ($challenge, $task-string);
    return &random-integers if ('nr233', 'task-two') ~~ ($challenge, $task-string);


    return &data-task-template if ('DEMO', 'task-one') ~~ ($challenge, $task-string);
    return &data-task-template if ('DEMO', 'task-two') ~~ ($challenge, $task-string);

    die "Data provider for $challenge not implemented.";
}

sub random-strings($entry, $min-length=1, $max-length=100) {
    state @problem-size = 1,10,100,1000,10000 ... Inf;
    state @data is default([]);
    
    my $n = @problem-size[$entry];
    
    my $alphabet = ('a'..'z') ∪ ('A'..'Z') ∪ (0..9) ∪ ("\c[PENGUIN]", "\c[BELL]");
    my $word-lenght = $min-length .. $max-length;
    
    unless @data[$n].elems {
        my @this-data;
        @this-data.push: $alphabet.roll($word-lenght.roll).join('') for ^$n;
        @data[$n] = @this-data;
    }
    return @data[$n];
}

sub random-integers($entry, $min=-100, $max=100) {
    state @problem-size = 1,10,100,1000,10000 ... Inf;
    state @data is default([]);
    my $n = @problem-size[$entry];
    @data[$n] = ($min..$max).roll($n) unless @data[$n].elems;
    return @data[$n];
}

sub data-task-template($entry) {
    state @problem-size = 1,10,100,1000,10000 ... Inf;
    state @data is default([]);
    @data[@problem-size[$entry]] = ^(@problem-size[$entry]) unless @data[@problem-size[$entry]].elems;
    return @data[@problem-size[$entry]];
}
