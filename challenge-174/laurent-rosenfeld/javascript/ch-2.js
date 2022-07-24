function permute(inputArray) {
    let inAry = [...inputArray].sort(); //copy and sort input
    return inAry.reduce(function permute(res, item, key, arr) {
        return res.concat(arr.length > 1 && arr.slice(0, key)
            .concat(arr.slice(key + 1))
            .reduce(permute, [])
            .map(function (perm) {
                 return [item].concat(perm);
            }) || item);
    }, []);
}

function permutation2rank(perms, in_perm) {
    let input = JSON.stringify(in_perm)
    for (var i = 0; i < perms.length; i++) {
        // stringify permutations to enable comparison
        if (JSON.stringify(perms[i]) == input) {
            return i
        }
    }
}

function rank2permutation(perm_list, index) {
    return perm_list[index]
}

let perm_in = [3, 1, 2];
let perms = permute(perm_in)
console.log(perms)
let rank = permutation2rank(perms, perm_in)
console.log("Permutation", perm_in, "has rank", rank)
for (var i = 0; i < perms.length; i++) {
    console.log("Rank: ", i, " -> permutation ", rank2permutation(perms, i))
}
