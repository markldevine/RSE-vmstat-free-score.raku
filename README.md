Raku Service Environment - vmstat-free-score.raku
=================================================
A script to characterize system resource availability resulting in a final
freedom score (0..100, higher = more idle) using hysteresis over N samples.

After the score is calculated, it is uploaded to a sorted set in Valkey for
a single cycle answer as to which worker node is most idle.
