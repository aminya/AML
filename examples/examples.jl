using AML

@aml struct Person "person"
    age::UInt, "age"
    field::String, "study-field"
    GPA::Float64 = 4.5, "GPA"
    courses::Vector{String}, "taken-courses"
    ID::Int64, a"id"
end


@aml struct University "university"
    name, a"university-name"
    people::Vector{Person}, "students"
end

P1 = Person(age=24, field="Mechanical Engineering", courses=["Artificial Intelligence", "Robotics"], ID = 1)
P2 = Person(age=18, field="Computer Engineering", GPA=4, courses=["Julia"], ID = 2)

U = University(name="Julia University", people=[P1, P2])

print(P1.aml)
#=
<person id="1">
  <age>24</age>
  <study-field>Mechanical Engineering</study-field>
  <GPA>4.5</GPA>
  <taken-courses>Artificial Intelligence</taken-courses>
  <taken-courses>Robotics</taken-courses>
</person>
=#

print(P2.aml)
#=
<person id="2">
  <age>18</age>
  <study-field>Computer Engineering</study-field>
  <GPA>4</GPA>
  <taken-courses>Julia</taken-courses>
</person>
=#

print(U.aml)
#=
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
    <GPA>4</GPA>
    <taken-courses>Julia</taken-courses>
  </person>
</university>
=#