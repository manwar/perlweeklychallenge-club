unit module benchmark-data-generator:ver<0.0.1>:auth<rcmlz@github.com)>;

sub data-provider-for($challenge, Str $task-string) is export {
    return &data-task-template if ('nr000', 'task-one') ~~ ($challenge, $task-string);
    return &data-task-template if ('nr000', 'task-two') ~~ ($challenge, $task-string);


    return &data-task-template if ('DEMO', 'task-one') ~~ ($challenge, $task-string);
    return &data-task-template if ('DEMO', 'task-two') ~~ ($challenge, $task-string);

    die "Data provider for $challenge not implemented.";
}

sub data-task-template($entry) {
    state @problem-size = 1,10,100,1000,10000 ... Inf;
    state @data is default([]);
    @data[@problem-size[$entry]] = ^(@problem-size[$entry]) unless @data[@problem-size[$entry]].elems;
    return @data[@problem-size[$entry]];
}
