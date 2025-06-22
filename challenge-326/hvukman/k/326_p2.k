decompress: {x[0]#x[1]}
"ex 1"
ints: 1 3 2 4
{decompress x}'(2 2 # ints)
"ex 2"
ints2: 1 1 2 2
{decompress x}'(2 2 # ints2)
"ex 3"
ints3: 3 1 3 2
{decompress x}'(2 2 # ints3)


