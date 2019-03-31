{ no strict; no warnings; map { (fizz)[$_%3].(buzz)[$_%5]||$_ } 1..20 }
