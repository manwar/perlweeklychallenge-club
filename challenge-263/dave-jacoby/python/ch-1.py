#!/usr/bin/env python3

def main():
    examples = [ { 'k':2, 'ints':[1, 5, 3, 2, 4, 2 ] }, { 'k':6, 'ints':[1, 2, 4, 3, 5 ] }, { 'k':4, 'ints':[5, 3, 2, 4, 2, 1 ] } ]
    for e in examples:
        output = target_index( e )
        o = ",".join(output)
        ints = e["ints"].copy()
        i = ','.join(map(str,ints))
        k = str(e["k"])
        print("Input:  k={}, i=[{}]\nOutput: output=[{}]\n".format(k,i,o))

def target_index( obj ):
    output = []
    k = obj["k"]
    ints = obj["ints"].copy()
    ints.sort()
    for i, item in enumerate(ints):
        if item == k:
            output.append(str(i))
    return(output)

if __name__ == '__main__':
    main()
