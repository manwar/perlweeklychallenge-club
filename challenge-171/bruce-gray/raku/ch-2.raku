my &compose := &[∘]; # This single binding is the complete solution to the task.


# Testing:
my &h = compose &ffff, &gggg;

sub ffff ($p) { say "Calculating {&?ROUTINE.name} of $p"; $p * 2 }
sub gggg ($p) { say "Calculating {&?ROUTINE.name} of $p"; $p / 3 }

say h(15);

# Function composition is already provided by Raku's ∘ infix operator.
# See: https://docs.raku.org/language/operators#infix_o,_infix_%E2%88%98

# Of interest: The creation of &h can occur *before* the definition of the subs that will compose it.

# TIMTOWTDI; any one of these lines could replace the first line:
# sub compose ( &f, &g --> Code ) { return &f ∘ &g }
# my &compose = -> &f, &g { &f ∘ &g };
# my &compose = { &^f ∘ &^g };
# my &compose = * ∘ *;
