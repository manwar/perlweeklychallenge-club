#You are given a list of integers, @list.
#
#Write a script to find out subsequence that respect Pattern 132. Return empty ar
#ray if none found.
#
#    Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < 
#a[k] < a[j].
#
#
#    Example 1
#
#    Input:  @list = (3, 1, 4, 2)
#    Output: (1, 4, 2) respect the Pattern 132.
#
#    Example 2
#
#    Input: @list = (1, 2, 3, 4)
#    Output: () since no susbsequence can be found.
#
#    Example 3
#
#    Input: @list = (1, 3, 2, 4, 6, 5)
#    Output: (1, 3, 2) if more than one subsequence found then return the first.
#
#    Example 4
#
#    Input: @list = (1, 3, 4, 2)
#    Output: (1, 3, 2)
F←{⊑⟨⟨⟩⟩∾˜(1‿¯1≡·×1‿2⊏-⟜»)¨⊸/ (⌊`∾¨⊢∾¨(⌊`⌾⌽)) 𝕩}
1‿3‿2 ≡ F ⟨1, 3, 2, 4, 6, 5⟩
1‿4‿2 ≡ F 3‿1‿4‿2
