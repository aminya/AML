export appendchild!, addelm!, appendChild
################################################################
# Creators
################################################################
# Document
################################################################
# Any
"""
    appendchild!(node, name, value, argAmlType)

Add one element to a node/document
"""
function appendchild!(aml::Document, name::String, value::T, argAmlType::Type{<:AbsDocOrNode}) where {T}

    if hasroot(aml)
        amlNode = root(aml)
        appendchild!(amlNode, name, value, argAmlType)
    elseif hasfield(T, :aml)
        setroot!(aml, value.aml)
    else
        error("You cannot insert $(T) in the document directly. Define a @aml defined field for xml or html document struct")
    end

end

# Nothing
function appendchild!(aml::Document, name::String, value::Nothing, argAmlType::Type{<:AbsDocOrNode})
# do nothing if value is nothing
end
################################################################
# Vector
"""
    appendchild!(node, name, value, argAmlType)

Add a vector to a node/document
```
"""
function appendchild!(aml::Document, name::String, value::Vector, argAmlType::Type{<:AbsDocOrNode})

    if hasroot(aml)
        amlNode = root(aml)
        appendchild!(amlNode, name, value, argAmlType)

    else
        error("You cannot insert a vector in the document directly. Define a @aml defined field for xml or html document struct")
    end

end

################################################################
# Nodes
################################################################
# String
@transform function appendchild!(aml::Node, name::String,value::AbstractString, argAmlType::Type{allsubtypes(AbsNormal)})
    if !isnothing(value) # do nothing if value is nothing
        addelement!(aml, name, value)
    end
end

function appendchild!(aml::Node, name::String,value::AbstractString, argAmlType::Type{AbsAttribute})
    if !isnothing(value) # do nothing if value is nothing
        link!(aml, AttributeNode(name, value))
    end
end

function appendchild!(aml::Node, indexstr::String,value::AbstractString, argAmlType::Type{AbsText})
    index = parse_textindex(indexstr)
    if index < length(elements(aml))
        desired_node = elements(aml)[index]
        if !isnothing(value) # do nothing if value is nothing
            linkprev!(desired_node, TextNode(value))
        end
    else
        desired_node = elements(aml)[end]
        if !isnothing(value) # do nothing if value is nothing
            linknext!(desired_node, TextNode(value))
        end
    end
end

# Number  (and also Bool <:Number)
@transform function appendchild!(aml::Node, name::String, value::Number, argAmlType::Type{allsubtypes(AbsNormal)})
    if !isnothing(value) # do nothing if value is nothing
        addelement!(aml, name, string(value))
    end
end

function appendchild!(aml::Node, name::String, value::Number, argAmlType::Type{AbsAttribute})
    if !isnothing(value) # do nothing if value is nothing
        link!(aml, AttributeNode(name, string(value)))
    end
end

function appendchild!(aml::Node, indexstr::String, value::Number, argAmlType::Type{AbsText})
    index = parse_textindex(indexstr)
    if index < length(elements(aml))
        desired_node = elements(aml)[index]
        if !isnothing(value) # do nothing if value is nothing
            linkprev!(desired_node, TextNode(string(value)))
        end
    else
        desired_node = elements(aml)[end]
        if !isnothing(value) # do nothing if value is nothing
            linknext!(desired_node, TextNode(string(value)))
        end
    end
end

# Other
function appendchild!(aml::Node, name::String, value::T, argAmlType::Type{<:AbsNormal}) where {T}
    if hasfield(T, :aml)
        link!(aml,value.aml)

    elseif Tables.istable(value)
        link!(aml,amlTable(value))

    elseif hasmethod(aml, Tuple{T})
        link!(aml,aml(value))

    else
        addelement!(aml, name, string(value))
    end
end

function appendchild!(aml::Node, name::String, value::T, argAmlType::Type{AbsAttribute}) where {T}
    if hasfield(T, :aml)
        link!(aml, AttributeNode(name, value.aml))

    elseif Tables.istable(value)
        link!(aml, AttributeNode(name, amlTable(value)))

    elseif hasmethod(aml, Tuple{T})
        link!(aml, AttributeNode(name, aml(value)))

    else
        link!(aml, AttributeNode(name, string(value)))
    end
end

function appendchild!(aml::Node, indexstr::String, value::T, argAmlType::Type{AbsText}) where {T}
    index = parse_textindex(indexstr)
    if index < length(elements(aml))

        desired_node = elements(aml)[index]
        if hasfield(T, :aml)
            linkprev!(desired_node, TextNode(value.aml))

        elseif Tables.istable(value)
            linkprev!(desired_node, TextNode(amlTable(value)))

        elseif hasmethod(aml, Tuple{T})
            linkprev!(desired_node, TextNode(aml(value)))

        else
            linkprev!(desired_node, TextNode(string(value)))
        end

    else
        desired_node = elements(aml)[end]
        if hasfield(T, :aml)
            linknext!(desired_node, TextNode(value.aml))

        elseif Tables.istable(value)
            linknext!(desired_node, TextNode(amlTable(value)))

        elseif hasmethod(aml, Tuple{T})
            linknext!(desired_node, TextNode(aml(value)))

        else
            linknext!(desired_node, TextNode(string(value)))
        end
    end
end

# Nothing
@transform function appendchild!(aml::Node, name::String, value::Nothing, argAmlType::Type{allsubtypes(AbsDocOrNode)})
    # do nothing
end
################################################################
# Vector

allsubtypes_butAbsText(t) = setdiff(allsubtypes(AbsDocOrNode), [AbsText])

@transform function appendchild!(aml::Node, name::String, values::Vector, argAmlType::Type{allsubtypes_butAbsText(AbsDocOrNode)})
    foreach(x-> appendchild!(aml, name, x, argAmlType), values)
end

function appendchild!(aml::Node, indicesstr::String, values::Vector, argAmlType::Type{AbsText})
    indices = parse_textindices(indicesstr)
    if indices isa Colon
        indices = 1:length(elements(aml))
    end
    foreach((x, i)-> appendchild!(aml, string(i), x, argAmlType), zip(values, indices))
end

################################################################
# Dict

@transform function appendchild!(aml::Node, name::String, values::AbstractDict, argAmlType::Type{allsubtypes(AbsDocOrNode)})
    # name is discarded now: actual names are stored in the Dict itself
    # elements are added directly
    # for AbsText, v_name is considered as the text index
    for (v_name, v_value) in values
        appendchild!(aml, v_name, v_value, argAmlType)
    end
end
################################################################
# Aliases
const addelm! = appendchild!
const appendChild! = appendchild!
