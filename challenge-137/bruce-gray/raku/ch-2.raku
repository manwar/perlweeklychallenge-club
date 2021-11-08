sub is-Lychrel-number ( Int $n is copy --> Bool ) {
    my $iterations;
    loop {
        $n += $n.flip;

        return False if $n eq $n.flip;
        return True  if $n            >= 10_000_000
                     or $iterations++ >  500;
    }
}

use Test;
my @tests = 
    # From the task description:
     56 => False,
     57 => False,
     59 => False,

    # Added:
    464 => True,    # Should be False, but not shown to be False inside the 10_000_000 limit, so True.
    196 => True,    # Famously huge
;    
plan +@tests;

for @tests -> ( :key($input), :value($expected) ) {
    is is-Lychrel-number($input), $expected,
        "is-Lychrel-number {$input.fmt('%3d')} == $expected";
}
