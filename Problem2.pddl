(define (problem subproblem2)


  (:domain underwaterExploration)

  (:objects
    ; objects used in the problem

    sub - sub

    pilot - personnel
    ; pilot as a personnel object

    ; locations (l1 to l8) represents different areas of the underwater world
    l1 - location
    l2 - location
    l3 - location
    l4 - location
    l5 - location
    l6 - location
    l7 - location
    l8 - location
    
  )

  (:init
    ; Initialize state of the world

    (dWater l1) ; l1 is deepWater
    (sWater l2) ; l2 is shallowWater
    (land l3) ; l3 is land
    (dWater l4) ; l4 is deepWater
    (sWater l5) ; l5 is shallowWater
    (sWater l6) ; l6 is shallowWater
    (dWater l7) ; l7 is deepWater
    (sWater l8) ; l8 is shallowWater

    (cmdCentre l1)
    ; command center is at location l1

    (pilot pilot)

    (pilotInSub sub)
    ; Indicate that the pilot is inside the submarine.

    (path l1 l2) ; path from l1 to l2
    (path l1 l4) ; path from l1 to l4
    (path l2 l3) ; path from l2 to l3
    (path l2 l1) ; path from l2 to l1
    (path l2 l5) ; path from l2 to l5
    (path l3 l2) ; path from l3 to l2
    (path l2 l1) ; path from l2 to l1
    (path l3 l6) ; path from l3 to l6
    (path l4 l1) ; path from l4 to l1
    (path l4 l5) ; path from l4 to l5
    (path l4 l7) ; path from l4 to l7
    (path l5 l4) ; path from l5 to l4
    (path l5 l2) ; path from l5 to l2
    (path l5 l6) ; path from l5 to l6 
    (path l5 l8) ; path from l5 to l8 
    (path l6 l3) ; path from l6 to l3
    (path l6 l5) ; path from l6 to l5
    (path l7 l4) ; path from l7 to l4
    (path l7 l8) ; path from l7 to l8
    (path l7 l8) ; path from l7 to l8
    (path l8 l5) ; path from l8 to l5
    (path l8 l7) ; path from l8 to l7
    (path l4 l3) ; path from l4 to l3

    ; Define paths between locations to represent connections
    (locationSub sub l1)
    ; Set the initial location of the submarine to l1
  )
  (:goal
    ; Define the goal conditions that need to be satisfied

    (and
     (locationSub sub l4)
    )
  )
)
