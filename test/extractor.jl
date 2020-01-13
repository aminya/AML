
@testset "extractor" begin

    xml = parsexml("""
    <?xml version="1.0" encoding="UTF-8"?>
    <university university-name="Julia University">
      <person id="1">
        <age>24</age>
        <study-field>Mechanical Engineering</study-field>
        <GPA>4.5</GPA>
        <taken-courses>Artificial Intelligence</taken-courses>
        <taken-courses>Robotics</taken-courses>
      </person>
      <person id="2">
        <age>18</age>
        <study-field>Computer Engineering</study-field>
        <GPA>4.2</GPA>
        <taken-courses>Julia</taken-courses>
      </person>
    </university>
    """)
    # extract Doc

    D = Doc(xml)

    # extract University

    U = D.university

    @test U.name == "Julia University"


    # extract Person

    P1 = U.people[1]

    @test P1.age == 24
    @test P1.field == "Mechanical Engineering"
    @test P1.GPA == 4.5
    @test P1.courses == ["Artificial Intelligence", "Robotics"]
    @test P1.id == 1

    P2 = U.people[2]

    @test stripall(@capture_out(pprint(P2))) == stripall("""
    <person id="2">
        <age>18</age>
        <study-field>Computer Engineering</study-field>
        <GPA>4.2</GPA>
        <taken-courses>Julia</taken-courses>
      </person>
    """)

end