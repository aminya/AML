using EzXML
import EzXML: Document, Node

import Tables

export docOrElmInit, UN
################################################################
UN{T}= Union{T, Nothing}
################################################################
include("xmlutils/creators.jl")
include("xmlutils/extractors.jl")
include("xmlutils/updaters.jl")
################################################################
