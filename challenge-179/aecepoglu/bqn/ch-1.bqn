no←⟨"","1st","2nd","3rd","4th" ,"5th","6th","7th","8th","9th"
   ,"10th","11th","12th","13th","14th","15th","16th","17th","18th","19th"
   ,"20th","30th","40th","50th","60th","70th","80th","90th",
   ,"hundredth","thousandth"⟩
nw←⟨"","one","two","three","four","five","six","seven","eight","nine"
   ,"ten" ,"eleven", "twelve", "thirteen", "fourteen", "fifteen"
   ,"sixteen", "seventeen", "eighteen", "nineteen"
   ,"twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
   ,"hundred", "thousand"⟩
nn←∞∾(1+↕19)∾(10×2↓↕10)∾10⋆2‿3
on←100≤nn

# I admit this is more than a bit ugly, bit it works and I really do not want to bother
Spoken←{∾((∧´1<≠¨)◶⋈‿⊢)¨ (0<≠¨)⊸/∾(0⊸≠)⊸(/⟜(⌽nw)(⋈¨)˜/⟜on(Spoken⊢×(⊣∧1⊸=)∨1⊸<)¨/)1⊸⊑¨{(<𝕩‿0)⊑⊸(|˜⋈⌊∘÷)`⌽nn}𝕩}
Ordinal←(no⊑˜nw⊸⊐⟜⋈)⌾(¯1⊸⊑) Spoken

Ordinal 25213
