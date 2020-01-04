export addelementOne!, addelementVect!
################################################################
# Init
################################################################
# doc or element initialize
"""
    docOrElmInit(name)
    docOrElmInit(type, name)

Function to initialize the aml

type:
0 : element node # default
10: empty element node
-1: xml
-2: html
"""
function docOrElmInit(type::Int64 = 0, name::String = nothing)

    if type == 0 # element node

        out = ElementNode(name)

    elseif type == 10 # empty element node

        out = ElementNode(name)

    elseif type == -1 # xml

        out = XMLDocument() # version 1

    elseif type == -2 # html

        out = HTMLDocument() # no URI and external id
    end

    return out
end

################################################################
# Creators
################################################################

# Document
#  defined or nothing for Documents # add strings and others for documents
"""
    addelementOne!(node, name, value, argAmlType)

Add one element to a node/document
```
"""
function addelementOne!(aml::Document, name::String, value::T, argAmlType::Int64) where {T}

    if !isnothing(value) # do nothing if value is nothing

        if hasroot(aml)
            amlNode = root(aml)
            if hasfield(T, :aml)
                link!(amlNode,value.aml)

            elseif Tables.istable(value)
                link!(amlNode,amlTable(value))

            elseif hasmethod(aml, Tuple{T})
                link!(amlNode,aml(value))

            else
                if argAmlType == 0 # normal elements

                    addelement!(aml, name, string(value))
                elseif argAmlType == 2 # Attributes

                    link!(aml, AttributeNode(name, string(value)))

                end
            end
        else
            setroot!(aml, value.aml)
        end

    end

end

# strings
function addelementOne!(aml::Document, name::String, value::String, argAmlType::Int64)

    if hasroot(aml)
        amlNode = root(aml)

        if argAmlType == 0 # normal elements

            addelement!(amlNode, name, value)

        elseif argAmlType == 2 # Attributes

            link!(amlNode, AttributeNode(name, value))

        end
    else
        error("You cannot insert a string in the document directly. Define a @aml defined field for xd/hd struct")
    end

end

# number
function addelementOne!(aml::Document, name::String, value::T, argAmlType::Int64) where {T<:Union{Number, Bool}}

    if hasroot(aml)
        amlNode = root(aml)

        if argAmlType == 0 # normal elements

            addelement!(amlNode, name, string(value))
        elseif argAmlType == 2 # Attributes

            link!(amlNode, AttributeNode(name, string(value)))

        end
    else
        error("You cannot insert a number in the document directly. Define a @aml defined field for xd/hd struct")
    end

end
################################################################
# vector of strings
"""
    addelementVect!(node, name, value, argAmlType)

Add a vector to a node/document
```
"""
function addelementVect!(aml::Document, name::String, value::Vector{String}, argAmlType::Int64)


    if hasroot(aml)
        amlNode = root(aml)

        if argAmlType == 0 # normal elements

            for ii = 1:length(value)
                if !isnothing(value[ii]) # do nothing if value is nothing
                    addelement!(amlNode, name, value[ii])
                end
            end

        elseif argAmlType == 2 # Attributes

            for ii = 1:length(value)
                if !isnothing(value[ii]) # do nothing if value is nothing
                    link!(amlNode, AttributeNode(name, value[ii]))
                end
            end
        end

    else
        error("You cannot insert a vector in the document directly. Define a @aml defined field for xd/hd struct")
    end

end

# vector of numbers
function addelementVect!(aml::Document, name::String, value::Vector{T}, argAmlType::Int64) where {T<:Union{Number, Bool}}

    if hasroot(aml)
        amlNode = root(aml)

        if argAmlType == 0 # normal elements

            for ii = 1:length(value)
                if !isnothing(value[ii]) # do nothing if value is nothing
                    addelement!(amlNode, name, string(value[ii]))
                end
            end

        elseif argAmlType == 2 # Attributes

            for ii = 1:length(value)
                if !isnothing(value[ii]) # do nothing if value is nothing
                    link!(amlNode, AttributeNode(name, string(value[ii])))
                end
            end
        end

    else
        error("You cannot put string in the document directly.Define a @aml defined field for xd/hd struct")
    end

end

#  vector of defined or nothing
function addelementVect!(aml::Document, name::String, value::Vector{T}, argAmlType::Int64) where {T}
    if hasroot(aml)
        amlNode = root(aml)

        for i = 1:length(value)
            vi = value[i]
            Ti = typeof(vi)

            if Ti !=== Nothing # do nothing if value is nothing

                if hasfield(Ti, :aml)
                    link!(amlNode,vi.aml)

                elseif Tables.istable(vi)
                    link!(amlNode, amlTable(vi))

                elseif hasmethod(aml, Tuple{Ti})
                    link!(amlNode, aml(vi))

                else
                    if argAmlType == 0 # normal elements

                        addelement!(amlNode, name, string(vi))
                    elseif argAmlType == 2 # Attributes

                        link!(amlNode, AttributeNode(name, string(vi)))

                    end
                end
            end

        end

    else
        error("You cannot put string in the document directly. Define a @aml defined field for xd/hd struct")
    end

end

################################################################
# Nodes
# strings
function addelementOne!(aml::Node, name::String, value::String, argAmlType::Int64)

    if !isnothing(value) # do nothing if value is nothing

        if argAmlType == 0 # normal elements

            addelement!(aml, name, value)

        elseif argAmlType == 2 # Attributes

            link!(aml, AttributeNode(name, value))

        end
    end
end

# number
function addelementOne!(aml::Node, name::String, value::T, argAmlType::Int64) where {T<:Union{Number, Bool}}

    if !isnothing(value) # do nothing if value is nothing

        if argAmlType == 0 # normal elements

            addelement!(aml, name, string(value))
        elseif argAmlType == 2 # Attributes

            link!(aml, AttributeNode(name, string(value)))

        end
    end
end

#  defined or nothing
function addelementOne!(aml::Node, name::String, value::T, argAmlType::Int64) where {T}
    if !isnothing(value)

        if hasfield(T, :aml)
            link!(aml,value.aml)

        elseif Tables.istable(value)
            link!(aml,amlTable(value))

        elseif hasmethod(aml, Tuple{T})
            link!(aml,aml(value))

        else
            if argAmlType == 0 # normal elements

                addelement!(aml, name, string(value))
            elseif argAmlType == 2 # Attributes

                link!(aml, AttributeNode(name, string(value)))

            end
        end
    end
end

# vector of strings
function addelementVect!(aml::Node, name::String, value::Vector{String}, argAmlType::Int64)


    if argAmlType == 0 # normal elements

        for ii = 1:length(value)
            if !isnothing(value[ii]) # do nothing if value is nothing
                addelement!(aml, name, value[ii])
            end
        end

    elseif argAmlType == 2 # Attributes

        for ii = 1:length(value)
            if !isnothing(value[ii]) # do nothing if value is nothing
                link!(aml, AttributeNode(name, value[ii]))
            end
        end
    end
end

# vector of numbers
function addelementVect!(aml::Node, name::String, value::Vector{T}, argAmlType::Int64) where {T<:Union{Number, Bool}}

    if argAmlType == 0 # normal elements

        for ii = 1:length(value)
            if !isnothing(value[ii]) # do nothing if value is nothing
                addelement!(aml, name, string(value[ii]))
            end
        end

    elseif argAmlType == 2 # Attributes

        for ii = 1:length(value)
            if !isnothing(value[ii]) # do nothing if value is nothing
                link!(aml, AttributeNode(name, string(value[ii])))
            end
        end
    end
end

#  vector of defined or nothing
function addelementVect!(aml::Node, name::String, value::Vector{T}, argAmlType::Int64) where {T}
    for ii = 1:length(value)
        vi = value[i]
        Ti = typeof(vi)

        if Ti !=== Nothing # do nothing if value is nothing

            if hasfield(Ti, :aml)
                link!(aml,value[ii].aml)

            elseif Tables.istable(vi)
                link!(aml, amlTable(vi))

            elseif hasmethod(aml, Tuple{Ti})
                link!(aml, aml(vi))

            else
                if argAmlType == 0 # normal elements

                    addelement!(aml, name, string(vi))
                elseif argAmlType == 2 # Attributes

                    link!(aml, AttributeNode(name, string(vi)))

                end
            end

        end
    end
end
