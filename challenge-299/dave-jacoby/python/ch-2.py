#!/usr/bin/python3

import copy

def main():
    examples = []
    examples.append(
        {
            "matrix": [
                ["A", "B", "D", "E"],
                ["C", "B", "C", "A"],
                ["B", "A", "A", "D"],
                ["D", "B", "B", "C"],
            ],
            "string": "BDCA",
        }
    )
    examples.append(
        {
            "matrix": [
                ["A", "A", "B", "B"],
                ["C", "C", "B", "A"],
                ["C", "A", "A", "A"],
                ["B", "B", "B", "B"],
            ],
            "string": "ABAC",
        },
    )
    examples.append(
        {
            "matrix": [
                ["B", "A", "B", "A"],
                ["C", "C", "C", "C"],
                ["A", "B", "A", "B"],
                ["B", "B", "A", "A"],
            ],
            "string": "CCCAA",
        }
    )
    for e in examples:
        matrix = display_matrix(e["matrix"], 21)
        string = e["string"]
        output = word_search(e)
        print(f'    Input:  string = "{string}"')
        print(f"            matrix: [{matrix}]")
        print(f"    Output: {output}")
        print("")


def word_search(e):
    string = e["string"]
    matrix = e["matrix"]
    mx = len([*matrix])
    my = len([*matrix[0]])
    letter = string[0:1]
    for i in [*range(mx)]:
        for j in [*range(my)]:
            p = matrix[i][j]
            if letter == p:
                lp = [i, j]
                path = []
                path.append(lp)
                output = start_word_search(e, path)
                if output == "true":
                    return "true"
    return "false"


def start_word_search(e, path):
    string = e["string"]
    matrix = e["matrix"]
    mx = len([*matrix])
    my = len([*matrix[0]])
    mp = len([*path])
    ms = len(string)
    choices = []
    choices.append([-1, 0])  # down
    choices.append([0, -1])  # left
    choices.append([0, 1])  # right
    choices.append([1, 0])  # up
    sofar = ""
    for i in [*range(mp)]:
        sofar += string[i:1]
    if mp > ms:
        return
    if mp == ms:
        return "true"
    loc = path[-1 + mp]
    pi = loc[0]
    pj = loc[1]
    nl = string[mp]
    done = []
    for i in range(mx + 1):
        row = []
        for j in range(my + 1):
            row.append("")
        done.append(row)
    for p in path:
        p0 = p[0]
        p1 = p[1]
        done[p0][p1] = 1
    for c in choices:
        ci = c[0]
        cj = c[1]
        i = pi + ci
        j = pj + cj
        if i >= 0 and i < mx:
            if j >= 0 and j < my:
                if 1 != done[i][j]:
                    v = matrix[i][j]
                    if v == nl:
                        p2 = copy.deepcopy(path)
                        p2.append([i,j])
                        output = start_word_search( e,p2 )
                        if output == "true":
                            return "true"
    return "false"


def display_matrix(matrix, size=5):
    output = ""
    pad = "".join(" " for i in [*range(size)])
    for m in matrix:
        output = output + str(m)
        output = output + "\n"
        output = output + pad
    return output


if __name__ == "__main__":
    main()
