# Custom Constructors - AcuteML Backend
## Making a Type and constructor from scratch

You can use AcuteML utilities to define custom type constructors from scratch or to override `@aml` defined constructors.

Notice that if you don't use `@aml`, you should include `aml::Node` as one of your fields.

Functions to use for custom html/xml constructor:
- [docOrElmInit](@ref): function to initialize the aml
- [addelementOne!](@ref) : to add single elements
- [addelementVect!](@ref) : to add multiple elements (vector)
Use these functions, to make a method that calculates the `aml` inside the function and returns all of the fields.

Functions to use for custom html/xml extractor:
- [findfirstcontent](@ref) : to extract single elements
- [findallcontent](@ref) : to extract multiple elements (vector)
Use these functions, to make a method that gets the `aml::Node` and calculates and returns all of the fields.

Functions to support mutability:
- [updatefirstcontent!](@ref): updates first element content. It also converts any type to string. element is given as string.
- [updateallcontent!](@ref): finds all the elements with the address of string in the node, and updates the content


# Example:
In this example we define `Identity` with custom constructors:
```julia
using AcuteML

mutable struct Identity
    pitch::UN{Pitch}
    rest::UN{Rest}
    unpitched::UN{Unpitched}
    aml::Node
end

function Identity(;pitch = nothing, rest = nothing, unpitched = nothing)

    # This constructor only allows one the fields to exist - similar to choice element in XS

    aml = docOrElmInit(AbsNormal, "identity")

    if pitch != nothing
        addelementOne!(aml, "pitch", pitch, AbsNormal)
    elseif rest != nothing
        addelementOne!(aml, "rest", rest, AbsNormal)
    elseif unpitched != nothing
        addelementOne!(aml, "unpitched", unpitched, AbsNormal)
    else
        error("one of the pitch, rest or unpitched should be given")
    end

    return Identity(pitch, rest, unpitched, aml)
end

function Identity(;aml)

        pitch = findfirstcontent(Pitch, "pitch", aml, AbsNormal)
        rest = findfirstcontent(Rest, "rest", aml, AbsNormal)
        unpitched = findfirstcontent(Unpitched, "unpitched", aml, AbsNormal)

        return Identity(pitch, rest, unpitched, aml)
end
```
