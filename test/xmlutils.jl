using AcuteML, Test
@testset "xmlutils" begin

    nsc = initialize_node(AbsEmpty, "some")

    @testset "Node" begin
        n = initialize_node(AbsNormal, "a")
        ################################################################
        appendchild!(n, "normalString", "val", AbsNormal)
        @test "val" == findcontent(String, "normalString", n, AbsNormal)
        @test ["val"] == findcontent("normalString", n, AbsNormal)

        updatecontent!("val2", "normalString", n, AbsNormal)
        @test "val2" == findcontent(String, "normalString", n, AbsNormal)

        appendchild!(n, "attString", "val", AbsAttribute)
        @test "val" == findcontent(String, "attString", n, AbsAttribute)
        updatecontent!("val2", "attString", n, AbsAttribute)
        @test "val2" == findcontent(String, "attString", n, AbsAttribute)

        using Dates
        appendchild!(n, "Date", Date(2013,7,1), AbsNormal)
        @test Date(2013,7,1) == findcontent(Date, "Date", n, AbsNormal)
        updatecontent!(Date(2013,7,2), "Date", n, AbsNormal)
        @test Date(2013,7,2) == findcontent(Date, "Date", n, AbsNormal)

        appendchild!(n, "Time", Time(12,53,40), AbsNormal)
        @test Time(12,53,40) == findcontent(Time, "Time", n, AbsNormal)
        updatecontent!(Time(12,53,41), "Time", n, AbsNormal)
        @test Time(12,53,41) == findcontent(Time, "Time", n, AbsNormal)

        appendchild!(n, "DateTime", DateTime(2013,5,1,12,53,40), AbsNormal)
        @test DateTime(2013,5,1,12,53,40) == findcontent(DateTime, "DateTime", n, AbsNormal)
        updatecontent!( DateTime(2013,5,1,12,53,41), "DateTime", n, AbsNormal)
        @test DateTime(2013,5,1,12,53,41) == findcontent(DateTime, "DateTime", n, AbsNormal)


        using DataFrames
        appendchild!(n, "DataFrame",  DataFrame(course = ["Artificial Intelligence", "Robotics"], professor = ["Prof. A", "Prof. B"] ), AbsNormal)
        @test_skip  DataFrame(course = ["Artificial Intelligence", "Robotics"], professor = ["Prof. A", "Prof. B"] ) ==  findcontent(DataFrame, "DataFrame", n, AbsNormal)
        # updatecontent!( DataFrame(course = ["Artificial Intelligence", "Robotics2"], professor = ["Prof. A", "Prof. B"] ),"DataFrame", n, AbsNormal)
        # @test_skip  DataFrame(course = ["Artificial Intelligence", "Robotics2"], professor = ["Prof. A", "Prof. B"] ) ==  findcontent(DataFrame, "DataFrame", n, AbsNormal)

        appendchild!(n, "Nothing", nothing, AbsAttribute)
        @test nothing == findcontent(Nothing, "Nothing", n, AbsAttribute)
        @test nothing == findcontent(Union{Nothing,String}, "Nothing", n, AbsAttribute)

        # updatecontent!(nothing, "Nothing", n, AbsAttribute)
        # @test nothing == findcontent(Nothing, "Nothing", n, AbsAttribute)

        ################################################################
        appendchild!(n, "stringVect", ["aa", "bb"], AbsNormal)
        @test ["aa", "bb"] == findcontent(Vector{String}, "stringVect", n, AbsNormal)
        updatecontent!(["aa2", "bb"], "stringVect", n, AbsNormal)
        @test ["aa2", "bb"] == findcontent(Vector{String}, "stringVect", n, AbsNormal)

        appendchild!(n, "floatVect", [5.6, 7.8], AbsNormal)
        @test [5.6, 7.8] == findcontent(Vector{Float64}, "floatVect", n, AbsNormal)
        updatecontent!([5.6, 7.9], "floatVect", n, AbsNormal)
        @test [5.6, 7.9] == findcontent(Vector{Float64}, "floatVect", n, AbsNormal)

        appendchild!(n, "intVect", [5, 6], AbsNormal)
        @test [5, 6] == findcontent(Vector{Int64}, "intVect", n, AbsNormal)
        updatecontent!([5, 7], "intVect", n, AbsNormal)
        @test [5, 7] == findcontent(Vector{Int64}, "intVect", n, AbsNormal)

        appendchild!(n, "DateVect", [Date(2013,7,1), Date(2014,7,1)], AbsNormal)
        @test [Date(2013,7,1), Date(2014,7,1)] == findcontent(Vector{Date}, "DateVect", n, AbsNormal)
        updatecontent!([Date(2013,7,2), Date(2014,7,1)], "DateVect", n, AbsNormal)
        @test [Date(2013,7,2), Date(2014,7,1)] == findcontent(Vector{Date}, "DateVect", n, AbsNormal)

        appendchild!(n, "TimeVect", [Time(12,53,42), Time(12,53,40)], AbsNormal)
        @test [Time(12,53,42), Time(12,53,40)] == findcontent(Vector{Time}, "TimeVect", n, AbsNormal)
        updatecontent!([Time(12,53,43), Time(12,53,40)], "TimeVect", n, AbsNormal)
        @test [Time(12,53,43), Time(12,53,40)] == findcontent(Vector{Time}, "TimeVect", n, AbsNormal)

        appendchild!(n, "AnyVect", ["aa", Time(12,53,40), 2, nothing], AbsNormal)
        @test string.(["aa", Time(12,53,40), 2]) == findcontent(typeof(["aa", Time(12,53,40), 2, nothing]), "AnyVect", n, AbsNormal)
        updatecontent!( ["aa", Time(12,53,40), 3, nothing], "AnyVect", n, AbsNormal)
        @test string.(["aa", Time(12,53,40), 3]) == findcontent(typeof(["aa", Time(12,53,40), 2, nothing]), "AnyVect", n, AbsNormal)
    end

    @testset "Html Document" begin
        dhtml = initialize_node(AbsHtml, "html")

        appendchild!(dhtml, "normalString", "val", AbsNormal)
        @test "val" == findcontent(String, "normalString", dhtml, AbsNormal)
        @test ["val"] == findcontent("normalString", dhtml, AbsNormal)

        updatecontent!("val2", "normalString", dhtml, AbsNormal)
        @test "val2" == findcontent(String, "normalString", dhtml, AbsNormal)

        appendchild!(dhtml, "attString", "val", AbsAttribute)
        @test "val" == findcontent(String, "attString", dhtml, AbsAttribute)
        updatecontent!("val2", "attString", dhtml, AbsAttribute)
        @test "val2" == findcontent(String, "attString", dhtml, AbsAttribute)

        using Dates
        appendchild!(dhtml, "Date", Date(2013,7,1), AbsNormal)
        @test Date(2013,7,1) == findcontent(Date, "Date", dhtml, AbsNormal)
        updatecontent!(Date(2013,7,2), "Date", dhtml, AbsNormal)
        @test Date(2013,7,2) == findcontent(Date, "Date", dhtml, AbsNormal)

        appendchild!(dhtml, "Time", Time(12,53,40), AbsNormal)
        @test Time(12,53,40) == findcontent(Time, "Time", dhtml, AbsNormal)
        updatecontent!(Time(12,53,41), "Time", dhtml, AbsNormal)
        @test Time(12,53,41) == findcontent(Time, "Time", dhtml, AbsNormal)

        appendchild!(dhtml, "DateTime", DateTime(2013,5,1,12,53,40), AbsNormal)
        @test DateTime(2013,5,1,12,53,40) == findcontent(DateTime, "DateTime", dhtml, AbsNormal)
        updatecontent!( DateTime(2013,5,1,12,53,41), "DateTime", dhtml, AbsNormal)
        @test DateTime(2013,5,1,12,53,41) == findcontent(DateTime, "DateTime", dhtml, AbsNormal)


        using DataFrames
        appendchild!(dhtml, "DataFrame",  DataFrame(course = ["Artificial Intelligence", "Robotics"], professor = ["Prof. A", "Prof. B"] ), AbsNormal)
        @test_skip  DataFrame(course = ["Artificial Intelligence", "Robotics"], professor = ["Prof. A", "Prof. B"] ) ==  findcontent(DataFrame, "DataFrame", dhtml, AbsNormal)
        # updatecontent!( DataFrame(course = ["Artificial Intelligence", "Robotics2"], professor = ["Prof. A", "Prof. B"] ),"DataFrame", dhtml, AbsNormal)
        # @test_skip  DataFrame(course = ["Artificial Intelligence", "Robotics2"], professor = ["Prof. A", "Prof. B"] ) ==  findcontent(DataFrame, "DataFrame", dhtml, AbsNormal)

        appendchild!(dhtml, "Nothing", nothing, AbsAttribute)
        @test nothing == findcontent(Nothing, "Nothing", dhtml, AbsAttribute)
        @test nothing == findcontent(Union{Nothing,String}, "Nothing", dhtml, AbsAttribute)

        # updatecontent!(nothing, "Nothing", dhtml, AbsAttribute)
        # @test nothing == findcontent(Nothing, "Nothing", dhtml, AbsAttribute)

        ################################################################
        appendchild!(dhtml, "stringVect", ["aa", "bb"], AbsNormal)
        @test ["aa", "bb"] == findcontent(Vector{String}, "stringVect", dhtml, AbsNormal)
        updatecontent!(["aa2", "bb"], "stringVect", dhtml, AbsNormal)
        @test ["aa2", "bb"] == findcontent(Vector{String}, "stringVect", dhtml, AbsNormal)

        appendchild!(dhtml, "floatVect", [5.6, 7.8], AbsNormal)
        @test [5.6, 7.8] == findcontent(Vector{Float64}, "floatVect", dhtml, AbsNormal)
        updatecontent!([5.6, 7.9], "floatVect", dhtml, AbsNormal)
        @test [5.6, 7.9] == findcontent(Vector{Float64}, "floatVect", dhtml, AbsNormal)

        appendchild!(dhtml, "intVect", [5, 6], AbsNormal)
        @test [5, 6] == findcontent(Vector{Int64}, "intVect", dhtml, AbsNormal)
        updatecontent!([5, 7], "intVect", dhtml, AbsNormal)
        @test [5, 7] == findcontent(Vector{Int64}, "intVect", dhtml, AbsNormal)

        appendchild!(dhtml, "DateVect", [Date(2013,7,1), Date(2014,7,1)], AbsNormal)
        @test [Date(2013,7,1), Date(2014,7,1)] == findcontent(Vector{Date}, "DateVect", dhtml, AbsNormal)
        updatecontent!([Date(2013,7,2), Date(2014,7,1)], "DateVect", dhtml, AbsNormal)
        @test [Date(2013,7,2), Date(2014,7,1)] == findcontent(Vector{Date}, "DateVect", dhtml, AbsNormal)

        appendchild!(dhtml, "TimeVect", [Time(12,53,42), Time(12,53,40)], AbsNormal)
        @test [Time(12,53,42), Time(12,53,40)] == findcontent(Vector{Time}, "TimeVect", dhtml, AbsNormal)
        updatecontent!([Time(12,53,43), Time(12,53,40)], "TimeVect", dhtml, AbsNormal)
        @test [Time(12,53,43), Time(12,53,40)] == findcontent(Vector{Time}, "TimeVect", dhtml, AbsNormal)

        appendchild!(dhtml, "AnyVect", ["aa", Time(12,53,40), 2, nothing], AbsNormal)
        @test string.(["aa", Time(12,53,40), 2]) == findcontent(typeof(["aa", Time(12,53,40), 2, nothing]), "AnyVect", dhtml, AbsNormal)
        updatecontent!( ["aa", Time(12,53,40), 3, nothing], "AnyVect", dhtml, AbsNormal)
        @test string.(["aa", Time(12,53,40), 3]) == findcontent(typeof(["aa", Time(12,53,40), 2, nothing]), "AnyVect", dhtml, AbsNormal)
    end

    @testset "XML Document" begin
        dxml = initialize_node(AbsXml, "xml")

        import EzXML: setroot!
        setroot!(dxml, initialize_node(AbsNormal, "node"))

        appendchild!(dxml, "normalString", "val", AbsNormal)
        @test "val" == findcontent(String, "normalString", dxml, AbsNormal)
        @test ["val"] == findcontent("normalString", dxml, AbsNormal)

        updatecontent!("val2", "normalString", dxml, AbsNormal)
        @test "val2" == findcontent(String, "normalString", dxml, AbsNormal)

        appendchild!(dxml, "attString", "val", AbsAttribute)
        @test "val" == findcontent(String, "attString", dxml, AbsAttribute)
        updatecontent!("val2", "attString", dxml, AbsAttribute)
        @test "val2" == findcontent(String, "attString", dxml, AbsAttribute)

        using Dates
        appendchild!(dxml, "Date", Date(2013,7,1), AbsNormal)
        @test Date(2013,7,1) == findcontent(Date, "Date", dxml, AbsNormal)
        updatecontent!(Date(2013,7,2), "Date", dxml, AbsNormal)
        @test Date(2013,7,2) == findcontent(Date, "Date", dxml, AbsNormal)

        appendchild!(dxml, "Time", Time(12,53,40), AbsNormal)
        @test Time(12,53,40) == findcontent(Time, "Time", dxml, AbsNormal)
        updatecontent!(Time(12,53,41), "Time", dxml, AbsNormal)
        @test Time(12,53,41) == findcontent(Time, "Time", dxml, AbsNormal)

        appendchild!(dxml, "DateTime", DateTime(2013,5,1,12,53,40), AbsNormal)
        @test DateTime(2013,5,1,12,53,40) == findcontent(DateTime, "DateTime", dxml, AbsNormal)
        updatecontent!( DateTime(2013,5,1,12,53,41), "DateTime", dxml, AbsNormal)
        @test DateTime(2013,5,1,12,53,41) == findcontent(DateTime, "DateTime", dxml, AbsNormal)


        using DataFrames
        appendchild!(dxml, "DataFrame",  DataFrame(course = ["Artificial Intelligence", "Robotics"], professor = ["Prof. A", "Prof. B"] ), AbsNormal)
        @test_skip  DataFrame(course = ["Artificial Intelligence", "Robotics"], professor = ["Prof. A", "Prof. B"] ) ==  findcontent(DataFrame, "DataFrame", dxml, AbsNormal)
        # updatecontent!( DataFrame(course = ["Artificial Intelligence", "Robotics2"], professor = ["Prof. A", "Prof. B"] ),"DataFrame", dxml, AbsNormal)
        # @test_skip  DataFrame(course = ["Artificial Intelligence", "Robotics2"], professor = ["Prof. A", "Prof. B"] ) ==  findcontent(DataFrame, "DataFrame", dxml, AbsNormal)

        appendchild!(dxml, "Nothing", nothing, AbsAttribute)
        @test nothing == findcontent(Nothing, "Nothing", dxml, AbsAttribute)
        @test nothing == findcontent(Union{Nothing,String}, "Nothing", dxml, AbsAttribute)

        # updatecontent!(nothing, "Nothing", dxml, AbsAttribute)
        # @test nothing == findcontent(Nothing, "Nothing", dxml, AbsAttribute)

        ################################################################
        appendchild!(dxml, "stringVect", ["aa", "bb"], AbsNormal)
        @test ["aa", "bb"] == findcontent(Vector{String}, "stringVect", dxml, AbsNormal)
        updatecontent!(["aa2", "bb"], "stringVect", dxml, AbsNormal)
        @test ["aa2", "bb"] == findcontent(Vector{String}, "stringVect", dxml, AbsNormal)

        appendchild!(dxml, "floatVect", [5.6, 7.8], AbsNormal)
        @test [5.6, 7.8] == findcontent(Vector{Float64}, "floatVect", dxml, AbsNormal)
        updatecontent!([5.6, 7.9], "floatVect", dxml, AbsNormal)
        @test [5.6, 7.9] == findcontent(Vector{Float64}, "floatVect", dxml, AbsNormal)

        appendchild!(dxml, "intVect", [5, 6], AbsNormal)
        @test [5, 6] == findcontent(Vector{Int64}, "intVect", dxml, AbsNormal)
        updatecontent!([5, 7], "intVect", dxml, AbsNormal)
        @test [5, 7] == findcontent(Vector{Int64}, "intVect", dxml, AbsNormal)

        appendchild!(dxml, "DateVect", [Date(2013,7,1), Date(2014,7,1)], AbsNormal)
        @test [Date(2013,7,1), Date(2014,7,1)] == findcontent(Vector{Date}, "DateVect", dxml, AbsNormal)
        updatecontent!([Date(2013,7,2), Date(2014,7,1)], "DateVect", dxml, AbsNormal)
        @test [Date(2013,7,2), Date(2014,7,1)] == findcontent(Vector{Date}, "DateVect", dxml, AbsNormal)

        appendchild!(dxml, "TimeVect", [Time(12,53,42), Time(12,53,40)], AbsNormal)
        @test [Time(12,53,42), Time(12,53,40)] == findcontent(Vector{Time}, "TimeVect", dxml, AbsNormal)
        updatecontent!([Time(12,53,43), Time(12,53,40)], "TimeVect", dxml, AbsNormal)
        @test [Time(12,53,43), Time(12,53,40)] == findcontent(Vector{Time}, "TimeVect", dxml, AbsNormal)

        appendchild!(dxml, "AnyVect", ["aa", Time(12,53,40), 2, nothing], AbsNormal)
        @test string.(["aa", Time(12,53,40), 2]) == findcontent(typeof(["aa", Time(12,53,40), 2, nothing]), "AnyVect", dxml, AbsNormal)
        updatecontent!( ["aa", Time(12,53,40), 3, nothing], "AnyVect", dxml, AbsNormal)
        @test string.(["aa", Time(12,53,40), 3]) == findcontent(typeof(["aa", Time(12,53,40), 2, nothing]), "AnyVect", dxml, AbsNormal)
    end


end
