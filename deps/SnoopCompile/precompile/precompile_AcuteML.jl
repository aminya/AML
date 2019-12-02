function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    precompile(Tuple{typeof(AcuteML._aml), Expr})
    isdefined(AcuteML, Symbol("#@aml")) && precompile(Tuple{getfield(AcuteML, Symbol("#@aml")), LineNumberNode, Module, Int})
    precompile(Tuple{typeof(AcuteML.findalllocal), String, EzXML.Node})
    precompile(Tuple{typeof(AcuteML.findfirstlocal), String, EzXML.Node})
    precompile(Tuple{typeof(AcuteML.findfirstcontent), Type{Float64}, String, EzXML.Node, Int64})
    precompile(Tuple{typeof(AcuteML.findallcontent), Type{Array{Main.Person, 1}}, String, EzXML.Node, Int64})
    precompile(Tuple{typeof(AcuteML.addelementVect!), EzXML.Node, String, Array{String, 1}, Int64})
    precompile(Tuple{typeof(AcuteML.findallcontent), Type{Array{Main.Person, 1}}, String, EzXML.Node, Int64})
    precompile(Tuple{typeof(AcuteML.findfirstcontent), Type{Int64}, String, EzXML.Node, Int64})
    precompile(Tuple{typeof(AcuteML.addelementVect!), EzXML.Node, String, Array{Main.Person, 1}, Int64})
    precompile(Tuple{typeof(AcuteML.findfirstcontent), Type{UInt64}, String, EzXML.Node, Int64})
    precompile(Tuple{typeof(AcuteML.findallcontent), Type{Array{String, 1}}, String, EzXML.Node, Int64})
    precompile(Tuple{typeof(AcuteML.findfirstcontent), Type{Main.University}, String, EzXML.Document, Int64})
    precompile(Tuple{typeof(AcuteML.addelementOne!), EzXML.Node, String, Float64, Int64})
    precompile(Tuple{typeof(AcuteML.findfirstcontent), Type{Main.University}, String, EzXML.Document, Int64})
    precompile(Tuple{typeof(AcuteML.addelementOne!), EzXML.Node, String, Int64, Int64})
    isdefined(AcuteML, Symbol("#@a_str")) && precompile(Tuple{getfield(AcuteML, Symbol("#@a_str")), LineNumberNode, Module, Int})
    precompile(Tuple{typeof(AcuteML.updatefirstcontent!), Float64, String, EzXML.Document, Int64})
    isdefined(AcuteML, Symbol("#@xd_str")) && precompile(Tuple{getfield(AcuteML, Symbol("#@xd_str")), LineNumberNode, Module, Int})
    precompile(Tuple{typeof(AcuteML.updatefirstcontent!), Float64, String, EzXML.Node, Int64})
    precompile(Tuple{typeof(AcuteML.addelementOne!), EzXML.Document, String, Main.University, Int64})
    precompile(Tuple{typeof(AcuteML.findfirstcontent), Type{String}, String, EzXML.Node, Int64})
end
