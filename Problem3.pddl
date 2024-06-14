(define (problem enableShield)

  (:domain underwaterExploration)
  ; Specify the domain for this problem.

  (:objects
    sub1 - sub 
    ; Define an object named 'sub1' of type 'sub.'
  )

  (:init
    ; Initialize state of the world

    (shieldDisabled sub1)
    ; shield of 'sub1' is initially disabled.

    (pilotInSub sub1)
    ; there is a pilot in 'sub1'.
  )

  (:goal
    (not (shieldDisabled sub1))
  )
)
