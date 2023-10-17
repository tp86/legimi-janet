(defn serialize-int
  [i]
  (ffi/write :int32 i))

(defn deserialize-int
  [buf]
  (ffi/read :int32 buf))
