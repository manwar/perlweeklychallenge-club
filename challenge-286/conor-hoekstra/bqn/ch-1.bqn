# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/286-1.bqn

⟨Split⟩ ⇐ •Import "../lib/string.bqn"

•Out (•rand.Range∘≠⊸⊑) ' ' Split ∾´ •file.Lines "286-1.bqn"
