var documenterSearchIndex = {"docs":
[{"location":"SyntaxReference/#","page":"Syntax Reference","title":"Syntax Reference","text":"","category":"page"},{"location":"SyntaxReference/#Main-Macro-and-IO-1","page":"Syntax Reference","title":"Main Macro and IO","text":"","category":"section"},{"location":"SyntaxReference/#","page":"Syntax Reference","title":"Syntax Reference","text":"Modules = [AML]\nPages   = [\"AML.jl\"]","category":"page"},{"location":"SyntaxReference/#EzXML.parsehtml","page":"Syntax Reference","title":"EzXML.parsehtml","text":"parsehtml(htmlstring)\n\nParse htmlstring and create an HTML document.\n\n\n\n\n\n\n\n","category":"function"},{"location":"SyntaxReference/#EzXML.parsexml","page":"Syntax Reference","title":"EzXML.parsexml","text":"parsexml(xmlstring)\n\nParse xmlstring and create an XML document.\n\n\n\n\n\n\n\n","category":"function"},{"location":"SyntaxReference/#EzXML.readhtml","page":"Syntax Reference","title":"EzXML.readhtml","text":"readhtml(filename)\n\nRead filename and create an HTML document.\n\n\n\n\n\nreadhtml(input::IO)\n\nRead input and create an HTML document.\n\n\n\n\n\n\n\n","category":"function"},{"location":"SyntaxReference/#EzXML.readxml","page":"Syntax Reference","title":"EzXML.readxml","text":"readxml(filename)\n\nRead filename and create an XML document.\n\n\n\n\n\nreadxml(input::IO)\n\nRead input and create an XML document.\n\n\n\n\n\n\n\n","category":"function"},{"location":"SyntaxReference/#AML.@aml-Tuple{Any}","page":"Syntax Reference","title":"AML.@aml","text":"@aml typedef\n\nUse @aml macro to define a Julia type, and then the package automatically creates a xml or html associated with the defined type.\n\nType defnition\n\nUse xd\"\" or hd\"\" to define a XML or HTML document:\n\n@aml struct Doc xd\"\"\n\nSpecify the element name in a string after the struct name\n\n@aml struct Person \"person\"\n\nSepecify the html/xml name for childs in a string in front of the field after ,\n\nage::UInt, \"age\"\n\nFor already @aml defined types, name should be the same as its html/xml name\n\nuniversity::University, \"university\"\n\nIf the value is going to be an attribute put a before its name\n\nID::Int64, a\"id\"\n\nYou can specify the default value for an argument by using = defVal syntax\n\nGPA::Float64 = 4.5, \"GPA\"\n\nExample 1 - constructor\n\nusing AML\n\n@aml struct Person \"person\"\n    age::UInt, \"age\"\n    field::String, \"study-field\"\n    GPA::Float64 = 4.5, \"GPA\"\n    courses::Vector{String}, \"taken-courses\"\n    ID::Int64, a\"id\"\nend\n\n@aml struct University \"university\"\n    name, a\"university-name\"\n    people::Vector{Person}, \"person\"\nend\n\n@aml struct Doc xd\"\"\n    university::University, \"university\"\nend\n\n\nP1 = Person(age=24, field=\"Mechanical Engineering\", courses=[\"Artificial Intelligence\", \"Robotics\"], ID = 1)\nP2 = Person(age=18, field=\"Computer Engineering\", GPA=4, courses=[\"Julia\"], ID = 2)\n\nU = University(name=\"Julia University\", people=[P1, P2])\n\nD = Doc(university = U)\n\njulia> print(P1.aml)\n<person id=\"1\">\n  <age>24</age>\n  <study-field>Mechanical Engineering</study-field>\n  <GPA>4.5</GPA>\n  <taken-courses>Artificial Intelligence</taken-courses>\n  <taken-courses>Robotics</taken-courses>\n</person>\n\njulia> print(P2.aml)\n<person id=\"2\">\n  <age>18</age>\n  <study-field>Computer Engineering</study-field>\n  <GPA>4</GPA>\n  <taken-courses>Julia</taken-courses>\n</person>\n\njulia> print(U.aml)\n<university university-name=\"Julia University\">\n  <person id=\"1\">\n    <age>24</age>\n    <study-field>Mechanical Engineering</study-field>\n    <GPA>4.5</GPA>\n    <taken-courses>Artificial Intelligence</taken-courses>\n    <taken-courses>Robotics</taken-courses>\n  </person>\n  <person id=\"2\">\n    <age>18</age>\n    <study-field>Computer Engineering</study-field>\n    <GPA>4</GPA>\n    <taken-courses>Julia</taken-courses>\n  </person>\n</university>\n\njulia> print(D.aml)\n<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<university university-name=\"Julia University\">\n  <person id=\"1\">\n    <age>24</age>\n    <study-field>Mechanical Engineering</study-field>\n    <GPA>4.5</GPA>\n    <taken-courses>Artificial Intelligence</taken-courses>\n    <taken-courses>Robotics</taken-courses>\n  </person>\n  <person id=\"2\">\n    <age>18</age>\n    <study-field>Computer Engineering</study-field>\n    <GPA>4</GPA>\n    <taken-courses>Julia</taken-courses>\n  </person>\n</university>\n\n\nExample 2 - extractor\n\nusing AML\n\nxml = parsexml(\"\"\"\n<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<university university-name=\"Julia University\">\n  <person id=\"1\">\n    <age>24</age>\n    <study-field>Mechanical Engineering</study-field>\n    <GPA>4.5</GPA>\n    <taken-courses>Artificial Intelligence</taken-courses>\n    <taken-courses>Robotics</taken-courses>\n  </person>\n  <person id=\"2\">\n    <age>18</age>\n    <study-field>Computer Engineering</study-field>\n    <GPA>4</GPA>\n    <taken-courses>Julia</taken-courses>\n  </person>\n</university>\n\"\"\")\n\n@aml struct Person \"person\"\n    age::UInt, \"age\"\n    field::String, \"study-field\"\n    GPA::Float64 = 4.5, \"GPA\"\n    courses::Vector{String}, \"taken-courses\"\n    ID::Int64, a\"id\"\nend\n\n@aml struct University \"university\"\n    name, a\"university-name\"\n    people::Vector{Person}, \"person\"\nend\n\n@aml struct Doc xd\"\"\n    university::University, \"university\"\nend\n\n# extract Doc\n\nD = Doc(xml)\n\n\n# extract University\n\nU = University(D.university)\n\njulia>U.name\n\"Julia University\"\n\n# extract Person\n\nP1 = Person(U.people[1])\n\njulia>P1.age\n24\n\njulia>P1.field\nMechanical Engineering\n\njulia>P1.GPA\n4.5\n\njulia>P1.courses\n[\"Artificial Intelligence\", \"Robotics\"]\n\njulia>P1.ID\n1\n\nP2 = Person(U.people[2])\n\n\n\n\n\n\n","category":"macro"},{"location":"SyntaxReference/#Templating-1","page":"Syntax Reference","title":"Templating","text":"","category":"section"},{"location":"SyntaxReference/#","page":"Syntax Reference","title":"Syntax Reference","text":"Modules = [AML]\nPages   = [\"templating.jl\"]","category":"page"},{"location":"SyntaxReference/#AML.newTemplate","page":"Syntax Reference","title":"AML.newTemplate","text":"newTemplate(name)\n\nCreate new destination html file as the template\n\nnewTemplate(name, :function)\n\nPrints a function to be used as a template\n\nExamples\n\n# you can create a file and edit the file directly by using\nnewTemplate(\"person\")\n\n## create person function to store out html template\nnewTemplate(\"person\", :function)\n\n\n\n\n\n","category":"function"},{"location":"SyntaxReference/#AML.render2file","page":"Syntax Reference","title":"AML.render2file","text":"render2file(destination, overwrite, var...)\n\nrender variables passed as an input to the destination file.\n\nYou should put var in the destination file/string so var is evaluated there. Pass the variables as keyword arguments with the same name you used in the html string/file. Variables should be string,\n\nIf you want to statically overwrite the file pass true as the 2nd argument to the function. Useful if you don't want a dynamic website.\n\nExamples\n\n# Add the following html code to the generated html file\n#=\n<person id=$(id)>\n  <age>$(age)</age>\n  <study-field>$(field)</study-field>\n  <GPA>$(GPA)</GPA>\n  <taken-courses>$(courses[1])</taken-courses>\n  <taken-courses>$(courses[2])</taken-courses>\n</person>\n=#\n\n# Specify the template (or its path), and also the variables for rendering\nout =render2file(\"person\", false,\n  id = 1,\n  age = 24,\n  field = \"Mechanical Engineering\",\n  GPA = 4.5,\n  courses = [\"Artificial Intelligence\", \"Robotics\"])\n\n# you pass `true` as the 2nd argument to owerwrite person.html statically.\n\n\n\n\n\n\n","category":"function"},{"location":"SyntaxReference/#Backend-utilities-1","page":"Syntax Reference","title":"Backend utilities","text":"","category":"section"},{"location":"SyntaxReference/#","page":"Syntax Reference","title":"Syntax Reference","text":"Modules = [AML]\nPages   = [\"utilities.jl\"]","category":"page"},{"location":"SyntaxReference/#AML.findallcontent-Union{Tuple{T}, Tuple{Type{Array{T,1}},String,Union{Document, Node},Int64}} where T<:Union{Nothing, String}","page":"Syntax Reference","title":"AML.findallcontent","text":"findallcontent(type, string, node)\n\nFinds all the elements with the address of string in the node, and converts the elements to Type object.\n\n\n\n\n\n","category":"method"},{"location":"SyntaxReference/#AML.findalllocal-Tuple{String,Union{Document, Node}}","page":"Syntax Reference","title":"AML.findalllocal","text":"findalllocal(s,node)\n\nfindalllocal with ignoring namespaces. It considers element.name for returning the elements\n\n\n\n\n\n","category":"method"},{"location":"SyntaxReference/#AML.findfirstcontent-Union{Tuple{T}, Tuple{Type{T},String,Union{Document, Node},Int64}} where T<:Union{Nothing, String}","page":"Syntax Reference","title":"AML.findfirstcontent","text":"findfirstcontent(element,node)\nfindfirstcontent(type,element,node)\n\nReturns first element content. It also convert to the desired format by passing type. element is given as string.\n\nfindfirstcontent(\"/instrument-name\",node)\nfindfirstcontent(UInt8,\"/midi-channel\",node)\n\n\n\n\n\n","category":"method"},{"location":"SyntaxReference/#AML.findfirstlocal-Tuple{String,Union{Document, Node}}","page":"Syntax Reference","title":"AML.findfirstlocal","text":"findfirstlocal(s, node)\n\nfindfirst with ignoring namespaces. It considers element.name for returning the elements\n\n\n\n\n\n","category":"method"},{"location":"templating/#Templating-1","page":"Templating","title":"Templating","text":"","category":"section"},{"location":"templating/#","page":"Templating","title":"Templating","text":"AML also provides a templating engine if you want to use templates instead of creating the types.","category":"page"},{"location":"templating/#","page":"Templating","title":"Templating","text":"","category":"page"},{"location":"templating/#Example-3-Template-Rendering-using-Functions-1","page":"Templating","title":"Example 3 - Template Rendering using Functions","text":"","category":"section"},{"location":"templating/#","page":"Templating","title":"Templating","text":"This method only uses functions that return string. You can build your desired string and call the function for rendering.","category":"page"},{"location":"templating/#","page":"Templating","title":"Templating","text":"## create person function to store out html template\nnewTemplate(\"person\", :function)\n\n\nfunction person(;id, age, field, GPA, courses)\n\n  # Build the taken courses section\n  loopOut=\"\"\n  for course in courses\n    loopOut = loopout * \"\"\" <taken-courses>$(course)</taken-courses>   \"\"\"\n  end\n\n  # Append all the sections and varuables together\n  out = \"\"\"\n  <person id=$(id)>\n    <age>$(age)</age>\n    <study-field>$(field)</study-field>\n    <GPA>$(GPA)</GPA>\n    $loopout\n  </person>\n  \"\"\"\n\n  return out\nend\n\n# Call the function for rendering\nout = person(\n  id = \"1\",\n  age = \"24\",\n  field = \"Mechanical Engineering\",\n  GPA = \"4.5\",\n  courses = [\"Artificial Intelligence\", \"Robotics\"]\n)\n\nprint(out)\n\n# you can also write the output to a file:\nfile = open(filePath, \"r\"); print(file, out); close(file)","category":"page"},{"location":"templating/#","page":"Templating","title":"Templating","text":"","category":"page"},{"location":"templating/#Example-4-Template-Rendering-using-Files-1","page":"Templating","title":"Example 4 - Template Rendering using Files","text":"","category":"section"},{"location":"templating/#","page":"Templating","title":"Templating","text":"You can render variables into html/xml files. However, you can't have multiline control flow Julia code in this method.","category":"page"},{"location":"templating/#","page":"Templating","title":"Templating","text":"# only to set path to current file\ncd(@__DIR__)\n\n\n\n# you can create a file and edit the file directly by using\nnewTemplate(\"person\")\n\n# Add the following html code to the generated html file\n#=\n<person id=$(id)>\n  <age>$(age)</age>\n  <study-field>$(field)</study-field>\n  <GPA>$(GPA)</GPA>\n  <taken-courses>$(courses[1])</taken-courses>\n  <taken-courses>$(courses[2])</taken-courses>\n</person>\n=#\n\n# Specify the template (or its path), and also the variables for rendering\nout =render2file(\"person\", false,\n  id = 1,\n  age = 24,\n  field = \"Mechanical Engineering\",\n  GPA = 4.5,\n  courses = [\"Artificial Intelligence\", \"Robotics\"])\n\n# you pass `true` as the 2nd argument to owerwrite person.html statically.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"CurrentModule = AML","category":"page"},{"location":"#AML-1","page":"Home","title":"AML","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"AML web development package in Julia","category":"page"},{"location":"#","page":"Home","title":"Home","text":"It automatically creates/extracts HTML/XML files from Julia types!","category":"page"},{"location":"#Installation-1","page":"Home","title":"Installation","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Add the package","category":"page"},{"location":"#","page":"Home","title":"Home","text":"]add https://github.com/aminya/AML.jl","category":"page"},{"location":"#Usage-1","page":"Home","title":"Usage","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Use the package:","category":"page"},{"location":"#","page":"Home","title":"Home","text":"using AML","category":"page"},{"location":"#Main-macro-and-I/O-1","page":"Home","title":"Main macro and I/O","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Use @aml macro to define a Julia type, and then the package automatically creates a xml or html associated with the defined type.","category":"page"},{"location":"#Type-defnition-1","page":"Home","title":"Type defnition","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Use xd\"\" or hd\"\" to define a XML or HTML document:","category":"page"},{"location":"#","page":"Home","title":"Home","text":"@aml struct Doc xd\"\"","category":"page"},{"location":"#","page":"Home","title":"Home","text":"Specify the element name in a string after the struct name","category":"page"},{"location":"#","page":"Home","title":"Home","text":"@aml struct Person \"person\"","category":"page"},{"location":"#","page":"Home","title":"Home","text":"Sepecify the html/xml name for childs in a string in front of the field after ,","category":"page"},{"location":"#","page":"Home","title":"Home","text":"age::UInt, \"age\"","category":"page"},{"location":"#","page":"Home","title":"Home","text":"For already @aml defined types, name should be the same as its html/xml name","category":"page"},{"location":"#","page":"Home","title":"Home","text":"university::University, \"university\"","category":"page"},{"location":"#","page":"Home","title":"Home","text":"If the value is going to be an attribute put a before its name","category":"page"},{"location":"#","page":"Home","title":"Home","text":"ID::Int64, a\"id\"","category":"page"},{"location":"#","page":"Home","title":"Home","text":"You can specify the default value for an argument by using = defVal syntax","category":"page"},{"location":"#","page":"Home","title":"Home","text":"GPA::Float64 = 4.5, \"GPA\"","category":"page"},{"location":"#","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Example-1-Constructor-1","page":"Home","title":"Example 1 - Constructor","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"using AML\n\n@aml struct Person \"person\"\n    age::UInt, \"age\"\n    field::String, \"study-field\"\n    GPA::Float64 = 4.5, \"GPA\"\n    courses::Vector{String}, \"taken-courses\"\n    ID::Int64, a\"id\"\nend\n\n@aml struct University \"university\"\n    name, a\"university-name\"\n    people::Vector{Person}, \"person\"\nend\n\n@aml struct Doc xd\"\"\n    university::University, \"university\"\nend\n\n\nP1 = Person(age=24, field=\"Mechanical Engineering\", courses=[\"Artificial Intelligence\", \"Robotics\"], ID = 1)\nP2 = Person(age=18, field=\"Computer Engineering\", GPA=4, courses=[\"Julia\"], ID = 2)\n\nU = University(name=\"Julia University\", people=[P1, P2])\n\nD = Doc(university = U)","category":"page"},{"location":"#","page":"Home","title":"Home","text":"julia> print(P1.aml)\n<person id=\"1\">\n  <age>24</age>\n  <study-field>Mechanical Engineering</study-field>\n  <GPA>4.5</GPA>\n  <taken-courses>Artificial Intelligence</taken-courses>\n  <taken-courses>Robotics</taken-courses>\n</person>\n\njulia> print(P2.aml)\n<person id=\"2\">\n  <age>18</age>\n  <study-field>Computer Engineering</study-field>\n  <GPA>4</GPA>\n  <taken-courses>Julia</taken-courses>\n</person>\n\njulia> print(U.aml)\n<university university-name=\"Julia University\">\n  <person id=\"1\">\n    <age>24</age>\n    <study-field>Mechanical Engineering</study-field>\n    <GPA>4.5</GPA>\n    <taken-courses>Artificial Intelligence</taken-courses>\n    <taken-courses>Robotics</taken-courses>\n  </person>\n  <person id=\"2\">\n    <age>18</age>\n    <study-field>Computer Engineering</study-field>\n    <GPA>4</GPA>\n    <taken-courses>Julia</taken-courses>\n  </person>\n</university>\n\njulia> print(D.aml)\n<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<university university-name=\"Julia University\">\n  <person id=\"1\">\n    <age>24</age>\n    <study-field>Mechanical Engineering</study-field>\n    <GPA>4.5</GPA>\n    <taken-courses>Artificial Intelligence</taken-courses>\n    <taken-courses>Robotics</taken-courses>\n  </person>\n  <person id=\"2\">\n    <age>18</age>\n    <study-field>Computer Engineering</study-field>\n    <GPA>4</GPA>\n    <taken-courses>Julia</taken-courses>\n  </person>\n</university>\n","category":"page"},{"location":"#","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Example-2-Extractor-1","page":"Home","title":"Example 2 - Extractor","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"using AML\n\nxml = parsexml(\"\"\"\n<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<university university-name=\"Julia University\">\n  <person id=\"1\">\n    <age>24</age>\n    <study-field>Mechanical Engineering</study-field>\n    <GPA>4.5</GPA>\n    <taken-courses>Artificial Intelligence</taken-courses>\n    <taken-courses>Robotics</taken-courses>\n  </person>\n  <person id=\"2\">\n    <age>18</age>\n    <study-field>Computer Engineering</study-field>\n    <GPA>4</GPA>\n    <taken-courses>Julia</taken-courses>\n  </person>\n</university>\n\"\"\")\n\n@aml struct Person \"person\"\n    age::UInt, \"age\"\n    field::String, \"study-field\"\n    GPA::Float64 = 4.5, \"GPA\"\n    courses::Vector{String}, \"taken-courses\"\n    ID::Int64, a\"id\"\nend\n\n@aml struct University \"university\"\n    name, a\"university-name\"\n    people::Vector{Person}, \"person\"\nend\n\n@aml struct Doc xd\"\"\n    university::University, \"university\"\nend\n\n# extract Doc\n\nD = Doc(xml)\n\n\n# extract University\n\nU = University(D.university)\n\njulia>U.name\n\"Julia University\"\n\n\n# extract Person\n\nP1 = Person(U.people[1])\n\njulia>P1.age\n24\n\njulia>P1.field\nMechanical Engineering\n\njulia>P1.GPA\n4.5\n\njulia>P1.courses\n[\"Artificial Intelligence\", \"Robotics\"]\n\njulia>P1.ID\n1\n\nP2 = Person(U.people[2])\n","category":"page"}]
}
