# https://dev.to/jeongoon/weekly-challenge-080-task-2-kkj
#sub MAIN{(|@_,|((|@_,|@_.reverse).rotor(2=>-1).grep({[<] $_}))).elems.say}

# test with: raku jeongoon/raku/ch-2.raku 1 4 3 2
sub MAIN{(|@_,|(|@_.rotor(2=>-1).grep({[!=] $_}))).elems.say}

# --  off the challenge
# after reading other's code (where how markus-holzer count elements in a array)
#sub MAIN{(@_+(|@_.rotor(2=>-1).grep({[!=] $_}))).say}
