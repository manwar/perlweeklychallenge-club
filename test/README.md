
# New challenge

create next challenge for all users of previous week by using templates/
```
raku script/create-new-challenge-users.raku challenge-nr
```

or create for individual user only

```
raku script/create-new-challenge-users.raku challenge-nr your-user-id
```

# Data generator

Implement an appropriate data generator sub. Edit

```
test/benchmark-data-generator.rakumod
```

Maybe you are lucky and can re-use existing subs.

# Running Tests and Benchmarks

Run for booth tasks of challenge
```
raku --optimize=3 test/benchmark-scalabiity.raku challenge-DEMO
```

Run only for single task {task-one, task-two}
```
raku --optimize=3 test/benchmark-scalabiity.raku challenge-DEMO task-one
```

Replace challenge-DEMO and task-one accordingly

Find the results in data/

# Creating own solutions

edit booth files task-one.rakutest and task-two.rakutest and test with 

# Test own solution modules

For e.g. challenge nr234 and user rcmlz run in terminal:

```
raku --optimize=3 -I challenge-nr234/rcmlz/raku/ test/challenge-nr234/raku/task-two.rakutest
```