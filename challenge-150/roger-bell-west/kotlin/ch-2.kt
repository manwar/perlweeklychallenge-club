import kotlin.math.*

fun genprimes(mx: Int): ArrayList<Int> {
    var primesh=mutableSetOf<Int>()
    for (i in 2..3) {
        primesh.add(i)
    }
    for (i in 6..mx+1 step 6) {
        for (j in i-1..i+1 step 2) {
            if (j <= mx) {
                primesh.add(j)
            }
        }
    }
    var q=ArrayDeque(listOf(2,3,5,7))
    var p=q.removeFirst()
    val mr=sqrt(mx.toDouble()).toInt()
    while (p <= mr) {
        if (primesh.contains(p)) {
            for (i in p*p..mx step p) {
                primesh.remove(i)
            }
        }
        if (q.size < 2) {
            q.add(q.last()+4)
            q.add(q.last()+2)
        }
        p=q.removeFirst()
    }
    var primes=ArrayList(primesh.distinct())
    primes.sort()
    return primes
}

fun squarefree(max: Int): ArrayList<Int> {
    var out=ArrayList<Int>()
    val primes=genprimes(Math.sqrt(max.toDouble()).toInt())
    var plimit=1
    for (candidate in 1..max) {
        var squarefree=true
        while (plimit * plimit < candidate) {
            plimit += 1
        }
        var cc=candidate
        for (pr in primes) {
            if (pr > plimit) {
                break
            }
            var n=0
            while (cc % pr == 0) {
                n += 1
                if (n > 1) {
                    squarefree=false
                    break
                }
                cc /= pr
            }
            if (!squarefree) {
                break
            }
        }
        if (squarefree) {
            out.add(candidate)
        }
    }
    return out
}

fun main() {
    if (squarefree(30) == listOf(1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15,
                                 17, 19, 21, 22, 23, 26, 29, 30)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (squarefree(113) == listOf(1, 2, 3, 5, 6, 7, 10, 11, 13, 14,
                                  15, 17, 19, 21, 22, 23, 26, 29, 30,
                                  31, 33, 34, 35, 37, 38, 39, 41,
                                  42, 43, 46, 47, 51, 53, 55, 57, 58,
                                  59, 61, 62, 65, 66, 67, 69, 70,
                                  71, 73, 74, 77, 78, 79, 82, 83, 85,
                                  86, 87, 89, 91, 93, 94, 95, 97,
                                  101, 102, 103, 105, 106, 107, 109,
                                  110, 111, 113)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (squarefree(500) == listOf(1, 2, 3, 5, 6, 7, 10, 11, 13,
                                  14, 15, 17, 19, 21, 22, 23,
                                  26, 29, 30, 31, 33, 34, 35, 37,
                                  38, 39, 41, 42, 43, 46,
                                  47, 51, 53, 55, 57, 58, 59,
                                  61, 62, 65, 66, 67, 69, 70,
                                  71, 73, 74, 77, 78, 79, 82,
                                  83, 85, 86, 87, 89, 91, 93,
                                  94, 95, 97, 101, 102, 103,
                                  105, 106, 107, 109, 110, 111,
                                  113, 114, 115, 118, 119, 122,
                                  123, 127, 129, 130, 131,
                                  133, 134, 137, 138, 139, 141,
                                  142, 143, 145, 146, 149,
                                  151, 154, 155, 157, 158, 159,
                                  161, 163, 165, 166, 167,
                                  170, 173, 174, 177, 178, 179,
                                  181, 182, 183, 185, 186,
                                  187, 190, 191, 193, 194, 195,
                                  197, 199, 201, 202, 203,
                                  205, 206, 209, 210, 211, 213,
                                  214, 215, 217, 218, 219,
                                  221, 222, 223, 226, 227, 229,
                                  230, 231, 233, 235, 237,
                                  238, 239, 241, 246, 247, 249,
                                  251, 253, 254, 255, 257,
                                  258, 259, 262, 263, 265, 266,
                                  267, 269, 271, 273, 274,
                                  277, 278, 281, 282, 283, 285,
                                  286, 287, 290, 291, 293,
                                  295, 298, 299, 301, 302, 303,
                                  305, 307, 309, 310, 311,
                                  313, 314, 317, 318, 319, 321,
                                  322, 323, 326, 327, 329,
                                  330, 331, 334, 335, 337, 339,
                                  341, 345, 346, 347, 349,
                                  353, 354, 355, 357, 358, 359,
                                  362, 365, 366, 367, 370,
                                  371, 373, 374, 377, 379, 381,
                                  382, 383, 385, 386, 389,
                                  390, 391, 393, 394, 395, 397,
                                  398, 399, 401, 402, 403,
                                  406, 407, 409, 410, 411, 413,
                                  415, 417, 418, 419, 421,
                                  422, 426, 427, 429, 430, 431,
                                  433, 434, 435, 437, 438,
                                  439, 442, 443, 445, 446, 447,
                                  449, 451, 453, 454, 455,
                                  457, 458, 461, 462, 463, 465,
                                  466, 467, 469, 470, 471,
                                  473, 474, 478, 479, 481, 482,
                                  483, 485, 487, 489, 491,
                                  493, 494, 497, 498, 499)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
