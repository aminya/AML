function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    Base.precompile(Tuple{Core.kwftype(typeof(AcuteML.render2file)),NamedTuple{(:id, :age, :field, :GPA, :courses),Tuple{Int64,Int64,String,Float64,Array{String,1}}},typeof(render2file),String,Bool})
    Base.precompile(Tuple{typeof(AcuteML.aml_create),Expr,Array{Union{Expr, Symbol},1},Array{Any,1},Array{Union{Expr, Symbol, Type},1},Array{Union{Expr, Symbol},1},Array{Union{Missing, String},1},Array{Union{Missing, Function, Symbol},1},Array{Union{Missing, Type},1},String,Type,Array{Union{Missing, Function, Symbol},0},Bool,Array{Union{Nothing, Expr},1},Array{Union{Nothing, Expr},1},Array{Union{Nothing, Expr},1},Expr})
    Base.precompile(Tuple{typeof(AcuteML.aml_create),Expr,Array{Union{Expr, Symbol},1},Array{Any,1},Array{Union{Expr, Symbol, Type},1},Array{Union{Expr, Symbol},1},Array{Union{Missing, String},1},Array{Union{Missing, Function, Symbol},1},Array{Union{Missing, Type},1},String,Type,Array{Union{Missing, Function, Symbol},0},Bool,Array{Union{Nothing, Expr},1},Array{Union{Nothing, Expr},1},Array{Union{Nothing, Expr},1},Symbol})
    Base.precompile(Tuple{typeof(AcuteML.aml_parse),Expr})
    Base.precompile(Tuple{typeof(AcuteML.findfirsttext),Int64,Node})
    Base.precompile(Tuple{typeof(AcuteML.get_arg_xmlcreator),Expr,Bool,Expr,Expr,String,Type,Expr,QuoteNode,Expr})
    Base.precompile(Tuple{typeof(AcuteML.get_arg_xmlcreator),Nothing,Bool,Expr,Expr,String,Type,Expr,QuoteNode,Expr})
    Base.precompile(Tuple{typeof(AcuteML.get_arg_xmlextractor),Nothing,Bool,Expr,Expr,String,Type,Expr,QuoteNode,Expr})
    Base.precompile(Tuple{typeof(AcuteML.get_arg_xmludpater),Nothing,Bool,Expr,Expr,String,Type,Expr,QuoteNode,Expr})
    Base.precompile(Tuple{typeof(AcuteML.get_struct_xmlcreator),Expr,Array{Any,1},Array{Union{Expr, Symbol},1},Nothing,Expr,Array{Expr,1},Array{Expr,1},Nothing})
    Base.precompile(Tuple{typeof(AcuteML.get_struct_xmlextractor),Expr,Array{Any,1},Array{Expr,1},Nothing,Array{Expr,1},Nothing})
    Base.precompile(Tuple{typeof(AcuteML.multiString),Array{String,1}})
    Base.precompile(Tuple{typeof(AcuteML.multiString),Float64})
    Base.precompile(Tuple{typeof(AcuteML.multiString),Int64})
    Base.precompile(Tuple{typeof(AcuteML.multiString),String})
    Base.precompile(Tuple{typeof(AcuteML.nodeparse),Type,Node})
    Base.precompile(Tuple{typeof(addnode!),Document,String,Array{Any,1},Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Document,String,Array{Float64,1},Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Document,String,Array{Int64,1},Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Document,String,Array{String,1},Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Document,String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Document,String,Nothing,Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(addnode!),Document,String,String,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Node,String,Array{Any,1},Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Node,String,Array{Float64,1},Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Node,String,Array{Int64,1},Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Node,String,Int64,Type{AbsText}})
    Base.precompile(Tuple{typeof(addnode!),Node,String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(addnode!),Node,String,Nothing,Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(convert),Type{Union{Missing, Type}},Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(convert),Type{Union{Missing, Type}},Type{AbsNormal}})
    Base.precompile(Tuple{typeof(convert),Type{Union{Missing, Type}},Type{AbsText}})
    Base.precompile(Tuple{typeof(createnode),Type{AbsEmpty},String})
    Base.precompile(Tuple{typeof(createnode),Type{AbsHtml},String})
    Base.precompile(Tuple{typeof(createnode),Type{AbsHtml}})
    Base.precompile(Tuple{typeof(createnode),Type{AbsXml}})
    Base.precompile(Tuple{typeof(findcontent),String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Array{Any,1}},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Array{Any,1}},String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Array{Float64,1}},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Array{Float64,1}},String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Array{Int64,1}},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Array{Int64,1}},String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Array{String,1}},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Int64},String,Node,Type{AbsText}})
    Base.precompile(Tuple{typeof(findcontent),Type{Nothing},String,Document,Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(findcontent),Type{Nothing},String,Node,Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(findcontent),Type{String},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(findcontent),Type{Union{Nothing, String}},String,Document,Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(findcontent),Type{Union{Nothing, String}},String,Node,Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(newTemplate),String,Symbol})
    Base.precompile(Tuple{typeof(newTemplate),String})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Any,1},Array{Node,1},Node,Type})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Any,1},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Any,1},String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Float64,1},Array{Node,1},Node,Type})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Float64,1},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Float64,1},String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Int64,1},Array{Node,1},Node,Type})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Int64,1},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),Array{Int64,1},String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),Array{String,1},String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),Array{String,1},String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),Int64,String,Node,Type{AbsText}})
    Base.precompile(Tuple{typeof(updatecontent!),String,String,Document,Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(updatecontent!),String,String,Document,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),String,String,Node,Type{AbsAttribute}})
    Base.precompile(Tuple{typeof(updatecontent!),String,String,Node,Type{AbsNormal}})
    Base.precompile(Tuple{typeof(updatecontent!),String,String,Node,Type{AbsText}})
    isdefined(AcuteML, Symbol("##5#6")) && Base.precompile(Tuple{getfield(AcuteML, Symbol("##5#6")),Symbol})
end
