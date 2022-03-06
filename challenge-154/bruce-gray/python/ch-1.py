from itertools import permutations

input_words = "PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP LPER LPRE LEPR LRPE LREP".split()
input_set = set(input_words)

for i in permutations(list(input_words[0])):
    s = "".join(i)
    if s not in input_set:
        print(s)
