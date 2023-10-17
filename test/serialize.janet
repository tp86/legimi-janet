(use spork/test)
(use legimi/desser)

(start-suite "serialize single value")

(assert (deep= (serialize-int 17) @"\x11\0\0\0"))
(assert (= (deserialize-int @"\x11\0\0\0") 17))

(end-suite)
