sub secret-santa(@names) {
    my %assignments;

    loop {
        my @shuffled = @names.pick(*);
        %assignments = @names Z=> @shuffled;
        last if all(%assignments.map({ .key.split(' ').tail ne .value.split(' ').tail }));
    }

    return %assignments;
}

# Output
my @names = ('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross');
my %assigned = secret-santa(@names);

for %assigned.kv -> $giver, $receiver {
    say "$giver -> $receiver";
}
