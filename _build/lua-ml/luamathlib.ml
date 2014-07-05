
# 35 "luamathlib.nw"
module M (I : Lua.Lib.CORE) = struct
  module V = I.V
  let ( **-> ) = V.( **-> )
  let ( **->> ) x y = x **-> V.result y
  
# 12 "luamathlib.nw"
let float = V.float
let math_builtins =
  [ "abs",        V.efunc (float **->> float)            abs_float
  ; "acos",       V.efunc (float **->> float)            acos
  ; "asin",       V.efunc (float **->> float)            asin
  ; "atan",       V.efunc (float **->> float)            atan
  ; "atan2",      V.efunc (float **-> float **->> float) atan2
  ; "ceil",       V.efunc (float **->> float)            ceil
  ; "cos",        V.efunc (float **->> float)            cos
  ; "floor",      V.efunc (float **->> float)            floor
  ; "log",        V.efunc (float **->> float)            log
  ; "log10",      V.efunc (float **->> float)            log10
  ; "max",        V.efunc (float **-> float **->> float) max
  ; "min",        V.efunc (float **-> float **->> float) min
  ; "mod",        V.efunc (float **-> float **->> float) mod_float
  ; "sin",        V.efunc (float **->> float)            sin
  ; "sqrt",       V.efunc (float **->> float)            sqrt
  ; "tan",        V.efunc (float **->> float)            tan
  ; "random",     V.efunc (V.value **->> float)          (fun _ -> Random.float 1.0)
  ; "randomseed", V.efunc (V.int **->> V.unit)           Random.init
  ] 

# 39 "luamathlib.nw"

  let init = I.register_globals math_builtins
end
