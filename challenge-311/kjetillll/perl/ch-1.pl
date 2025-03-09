use v5.10;

sub upper_lower { pop() =~ s/./chr(ord$&^32)/ger }

for my $test (
    ["pERl"   => "PerL"],
    ["rakU"   => "RAKu"],
    ["PyThOn" => "pYtHoN"]
){
    my($input, $want) = @$test;
    my $got = upper_lower($input);
    say $want eq $got ? "ok" : "ERROR, want $want", "    $input → $got"
}
