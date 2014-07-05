
# 13 "ppcee.nw"
val ty:         Cee.ty          -> Pretty.t     (* type *)
val decl:       Cee.decl        -> Pretty.t     (* declaration *)
val expr:       Cee.expr        -> Pretty.t     (* expression  *)
val init:       Cee.init        -> Pretty.t     (* initializer *)
val stmts:      Cee.stmt list   -> Pretty.t     (* statements  *)
val fundef:     Cee.fundef      -> Pretty.t     (* function definition *)
val program:    Cee.program     -> Pretty.t     (* compilation unit *)
