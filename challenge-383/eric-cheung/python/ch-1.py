
class UnionFind:
    def __init__(self):
        self.parent = {}

    def find(self, i):
        ## Create a new node if it does not exist
        if i not in self.parent:
            self.parent[i] = i
            return i

        ## Path compression
        if self.parent[i] == i:
            return i

        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            self.parent[root_i] = root_j


def AreListSimilar(arrInput_01, arrInput_02, arrInput_03):
    ## If the lengths are different, the lists cannot be similar
    if len(arrInput_01) != len(arrInput_02):
        return False

    uf = UnionFind()

    ## Populate the Union-Find structure with the similarity map
    if len(arrInput_03) == 2:
        for strWord_01, strWord_02 in arrInput_03:
            uf.union(strWord_01, strWord_02)
    else:
        return True

    ## Compare elements at each position
    for w1, w2 in zip(arrInput_01, arrInput_02):
        if w1 == w2:
            continue

        ## Check if they belong to the same similarity group
        if uf.find(w1) != uf.find(w2):
            return False

    return True

## Example 1
## arrList_01 = ["great", "acting"]
## arrList_02 = ["fine", "drama"]
## arrList_03 = [["great", "fine"], ["acting", "drama"]]

## Example 2
## arrList_01 = ["apple", "pie"]
## arrList_02 = ["banana", "pie"]
## arrList_03 = [["apple", "peach"], ["peach", "banana"]]

## Example 3
## arrList_01 = ["perl4", "python"]
## arrList_02 = ["raku", "python"]
## arrList_03 = [["perl4", "perl5", "raku"]]

## Example 4
## arrList_01 = ["enjoy", "challenge"]
## arrList_02 = ["love", "weekly", "challenge"]
## arrList_03 = [["enjoy", "love"]]

## Example 5
arrList_01 = ["fast", "car"]
arrList_02 = ["quick", "vehicle"]
arrList_03 = [["enjoy", "love"]]

print (AreListSimilar(arrList_01, arrList_02, arrList_03))
