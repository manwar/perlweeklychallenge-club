my @lines = <0 248 260 514 1025 32>».base(2)».flip».trans:
     <0 1> => ( ' ', "\c[Female Sign]" );

.say for @lines[0x2BDB34EABC62D3.comb];

# Alternate solution:
# say .trans(<0 1> => [" ", "\c[Female Sign]"]) for 0xF820880A00C0180300600A022083E0100200403E010020.fmt(<%0187b>).comb(11);
