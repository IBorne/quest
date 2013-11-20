
# 13 "log.nw"
let sum = ref 0
let n   = ref 0

let bucket_length k =
  n := !n + 1;
  sum := !sum + k

let avg_length () =
  if !sum = 0 then 0.0
  else float_of_int (!sum) /. float_of_int (!n)
