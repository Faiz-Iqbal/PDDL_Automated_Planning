(define (problem subproblem)

  (:domain underwaterExploration)


  (:objects
    ;objects used in the problem (submarine, location, personnel, kits)

    ;submarines
    sub - sub
    sub2 - sub

    l1 - location
    l2 - location
    l3 - location
    l4 - location

    pilot - personnel
    pilot2 - personnel
    scientist - personnel
    engineer - personnel
    engineer2 - personnel

    kit - kits ; Structure kit
    kit2 - kits ; Energy kit 
    ckit3 - kits 
    ckit4 - kits
    ckit5 - kits
    ckit6 - kits
  )

  (:init
    ; Initialize the state of the world

    (base l1)
    ; base at location l1

    (cmdCentre l1)
    ; command center at l1

    (sWater l2) ; Shallow water
    (dWater l3) ; Deep water
    (dWater l4) ; Deep water

    (pilot pilot)
    (pilot pilot2)
    (scientist scientist)
    (engineer engineer)
    (engineer engineer2)
    ; Define various personnel

    (locationPers pilot l1)
    (locationPers pilot2 l1)
    (locationPers scientist l1)
    (locationPers engineer l1)
    (locationPers engineer2 l1)
    ; Specify the initial locations of personnel

    (path l1 l2)
    (path l2 l1)
    (path l2 l3)
    (path l3 l2)
    (path l3 l4)
    (path l4 l3)
    ; Define paths between locations to represent connections

    (locationSub sub l1)
    (emptySeatA sub)
    (emptySeatB sub)
    (kitEmpty sub)
    ; Specify attributes of the first submarine (sub)

    (strucKit kit)
    (locationKit l1 kit)
    ; Assign structure kit to the location l1

    (landEmpty l2)
    (landEmpty l3)
    (landEmpty l4)
    (nearLand l2)
    ; Land and proximity information

    (enrgyKit kit2)
    (locationKit l1 kit2)
    ; Assign energy kit to the location l1

    (locationSub sub2 l1)
    (emptySeatA sub2)
    (emptySeatB sub2)
    (kitEmpty sub2)
    ; Specify attributes of the second submarine (sub2)

    (strucKit ckit3)
    (locationKit l1 ckit3)
    (strucKit ckit4)
    (locationKit l1 ckit4)
    (strucKit ckit5)
    (locationKit l1 ckit5)
    (strucKit ckit6)
    (locationKit l1 ckit6)
    ; Additional structure kits at location l1

    (shieldDisabled sub)
    (shieldDisabled sub2)
    ; Indicate that the shields on both submarines are disabled
  )

  (:goal
    ; Define the goal conditions that need to be satisfied

    (and
      (tidalPwrGen l2)
      (cableBuilt l3)
      (surveyComplete l2)
      (searchedLocation l2)
      (uwBase l4)
      (sonarEnabled)
      ; Various conditions that need to be satisfied for the goal
    )
  )
)
