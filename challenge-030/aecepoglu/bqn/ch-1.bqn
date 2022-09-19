# Task 1
date←•Import "datetime.bqn"
DayOfWeek←{•BQN ¯1↓1⊑•SH "date"‿"-d"‿𝕩‿"+%u"}⟜('@'∾•Fmt) # 𝕩: date
>(7⊸=∘DayOfWeek∘date.From¨/⊢)∾⟜12‿25‿0‿0‿0¨(⊑+·↕-˜´)2019‿2101
