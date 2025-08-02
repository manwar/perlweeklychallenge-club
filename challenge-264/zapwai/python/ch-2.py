def proc(source, indices):
    print("Input: Source =", source, "Indices =", indices)
    target = []
    for i in range(len(source)):
        chunk = target[indices[i]:]
        target = target[0:indices[i]]
        while indices[i] >= len(target):
            target.append(None)
        target[indices[i]] = source[i]
        if len(chunk) > 0:
            for entry in chunk:
                target.append(entry)
    print("Output:", target)

source  = [0, 1, 2, 3, 4]
indices = [0, 1, 2, 2, 1]
proc(source, indices)

source  = [1, 2, 3, 4, 0]
indices = [0, 1, 2, 3, 0]
proc(source, indices)

source = [1]
indices = [0]
proc(source, indices)

