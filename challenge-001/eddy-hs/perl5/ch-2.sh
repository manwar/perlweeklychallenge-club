perl -E 'map {say( !($_ % 15)?"fizz buzz" : !($_ % 5)?"buzz" : !($_ % 3) ?"fizz" : $_)} (1..20)'


