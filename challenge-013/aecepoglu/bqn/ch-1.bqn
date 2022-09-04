date←•Import "/home/sahip/proj/shared/puzzles/datetime.bqn"
Fridays←{ #𝕩: year
 t0←date.From 𝕩‿1‿1‿0‿0‿0
 hd←×´24‿60‿60
 dow←•BQN ¯1↓1⊑•SH "date"‿"-d"‿('@'∾•Fmt t0)‿"+%u"
 <∘({𝕨∾"/"∾𝕩}´)˘•Fmt¨3⊸↑⌾⍉>⊑∘⌽¨1↓(1⊸⊑¨⊔⊢)date.To¨((5=1+7|1-˜dow+⊢)/(t0+hd×⊢))↕365
}

Fridays 2019
