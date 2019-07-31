# Perl Weekly Challenge - 018
# Task #2
#
# See
#     engineering.purdue.edu/~mark/pwc-018.pdf
# for more information.

# Run using Perl v6.d.
use v6.d;

# Priorites and values are stored in parallel arrays.
my (@priority, @value);

sub insert_with_priority($priority, $value)
{
    @priority.push($priority);  @value.push($value);
}

sub pull_highest_priority_element
{
    (is_empty)  and  return Nil;
    my $i = (0..^@priority).sort( {@priority[$^a] < @priority[$^b]}).head;
    my $value = @value[$i];
    @priority.splice($i, 1, ());  @value.splice($i, 1, ());
    return $value;
}

sub print_queue
{
    "print_queue".say;
    for (0..^@priority) -> $i
    {
        "    {@priority[$i]}  {@value[$i]}".say;
    }
}

sub is_empty
{
    return !@priority.elems;
}

print_queue;
insert_with_priority(5, "this is the first priority 5 item");
print_queue;
insert_with_priority(5, "this is the second priority 5 item");
print_queue;
insert_with_priority(4, "this is the first priority 4 item");
print_queue;
pull_highest_priority_element.say;
print_queue;
pull_highest_priority_element.say;
print_queue;
pull_highest_priority_element.say;
print_queue;
print_queue;
