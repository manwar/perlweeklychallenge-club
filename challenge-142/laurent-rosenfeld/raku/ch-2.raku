use v6;

await <6 8 1 12 2 14 5 2 1 0>.map: { start {sleep $_/2; .say} };
