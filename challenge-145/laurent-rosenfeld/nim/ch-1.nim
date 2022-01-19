proc dot_product (a1, a2: array[0..2, int]) : int =
    result = 0
    for i in 0..2:
        result += a1[i] * a2[i]
    return result

let a1 = [1, 2, 3]
let a2 = [4, 5, 6]
let res = dot_product(a1, a2)
echo "dot product: ", res
