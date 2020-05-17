raku -e 'say { $^a ~~ Str ?? .antipairs.grep(*.key eq $^a)[0].value + 1 !! $_[$^a - 1] given "A"..* }($_) for (28, "AD")'
