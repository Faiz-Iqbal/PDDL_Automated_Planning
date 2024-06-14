(define (domain underwaterExploration)
    (:requirements 
        :strips :typing :equality :negative-preconditions :disjunctive-preconditions :conditional-effects
    )

    (:types
        location
        personnel
        sub
        kits

    )

    (:predicates
        (land ?l) 
        (sWater ?l)
        (dWater ?l)
        (base ?l) 
        (landEmpty ?l)
        (nearLand ?l1)
        (tidalPwrGen ?l)
        (cableBuilt ?l)
        (nearTidalPwrGen ?l1)
        (nearCable ?l1)
        (protectedArea ?l)
        (krakenThere ?l)

        (cmdCentre ?b)
        (uwBase ?b)

        ; Personnel
        (engineer ?p)
        (scientist ?p)
        (pilot ?p)

        ; Kits
        (strucKit ?k) ;
        (enrgyKit ?k) ;

        ; Personnel in submarine
        (pilotInSub ?s) ; 
        (persInSub ?s ?p) ;

        ; Generating paths
        (path ?from ?to) ;(path ?from ?to)

        ; Submarine location
        (locationSub ?s ?l) ;
        (locationPers ?p ?l) ;
        (locationKit ?l ?k) ;

        ; Submarine capacity and shield status
        (emptySeatA ?s) ;
        (emptySeatB ?s) ;
        (kitEmpty ?s) ;
        (shieldDisabled ?s) ;
        (subCrashed ?s) ;

        ; Scan and survey
        (surveyComplete ?l) ; 
        (scanComplete ?l ?s) ; 
        (baseScnAvailable ?b ?l) ; 
        (searchedLocation ?l) ; 

        ; Base and sonar
        (base1) ; oneBase
        (base2) ; twoBase
        (sonarEnabled) ; sonarOn

    )


(:action navigateSubmarine ;
    :parameters
        (?s - sub ?from ?to)

    :precondition (and 
        (pilotInSub ?s)
        (path ?from ?to)
        (locationSub ?s ?from)
        (not (subCrashed ?s))
    )
    :effect
        (and
            (not (locationSub ?s ?from))
            (locationSub ?s ?to)
            (when (and (krakenThere ?to) (or (not(sonarEnabled)) (shieldDisabled ?s))) (subCrashed ?s))
            (when (and (krakenThere ?from) (or (not(sonarEnabled)) (shieldDisabled ?s))) (subCrashed ?s))
        )
    )


(:action perInsideSub 
    :parameters (?s - sub ?l - location ?p - personnel)

    :precondition (and 
        (not (subCrashed ?s))
        (base ?l)
        (or
            (emptySeatA ?s)
            (emptySeatB ?s)
        )
        (locationPers ?p ?l)
        (locationSub ?s ?l)
    )
    :effect (and 
        (persInSub ?s ?p)
        (not (locationPers ?p ?l))
        (when (not (emptySeatA ?s)) (not (emptySeatB ?s)))
        (when (emptySeatA ?s) (not (emptySeatA ?s)))
        (when (pilot ?p) (pilotInSub ?s))
        
    )
)

(:action persExitSub 
    :parameters (?s - sub ?l - location ?p - personnel)

    :precondition (and 
        (not (subCrashed ?s))
        (base ?l)
        (not (locationPers ?p ?l))
        (or
            (not (emptySeatA ?s))
            (not (emptySeatB ?s))
        )
        (locationSub ?s ?l)
        (persInSub ?s ?p)
    )
    :effect (and 
        (not (persInSub ?s ?p))
        (when (emptySeatA ?s) (emptySeatB ?s))
        (when (not (emptySeatA ?s)) (emptySeatA ?s))
        (when (pilot ?p) (not (pilotInSub ?s)))
        (locationPers ?p ?l)
    )
)

; Kits
(:action ldKit
    :parameters (?s - sub ?l - location ?p - personnel ?k - kits)

    :precondition (and 
        (not (subCrashed ?s))
        (cmdCentre ?l)
        (locationSub ?s ?l)
        (locationPers ?p ?l)
        (engineer ?p)
        (kitEmpty ?s)
        (locationKit ?l ?k)
        (or
            (strucKit ?k)
            (enrgyKit ?k)
        ))
    :effect (and 
        (not (kitEmpty ?s))
        (not (locationKit ?l ?k))
        (locationKit ?s ?k)
    )
)
(:action rmvKit 
    :parameters (?s - sub ?l - location ?p - personnel ?k - kits)

    :precondition (and 
        (not (subCrashed ?s))
        (cmdCentre ?l)
        (not (kitEmpty ?s))
        (locationKit ?s ?k)
        (locationPers ?p ?l)
        (locationSub ?s ?l)
        (engineer ?p)
        (or
            (strucKit ?k)
            (enrgyKit ?k)
        ))
    :effect (and 
        (kitEmpty ?s)
        (not (locationKit ?s ?k))
        (locationKit ?l ?k)
    )
)

(:action doSurvey 
    :parameters (
        ?s - sub
        ?l - location
        ?p - personnel
    )
    :precondition (and 
        (not (subCrashed ?s))
        (locationSub ?s ?l)
        (persInSub ?s ?p)
        (scientist ?p)
        (or
            (sWater ?l)
            (dWater ?l)
        )
        (not (surveyComplete ?l))
    )

    :effect (and 
        (surveyComplete ?l)
    )
)

(:action doScan 
    :parameters (
        ?s - sub
        ?l - location
        ?p - personnel
    )
    :precondition (and 
        (not (subCrashed ?s))
        (locationSub ?s ?l)
        (persInSub ?s ?p)
        (scientist ?p)
        (not (scanComplete ?l ?s))
    )
    
    :effect (and 
        (scanComplete ?l ?s)
    )
)

(:action buildTPG 
    :parameters (
        ?s - sub
        ?l - location
        ?p - personnel
        ?k - kits
    )
    :precondition (and 
        (not (subCrashed ?s))
        (locationSub ?s ?l)
        (persInSub ?s ?p)
        (engineer ?p)
        (sWater ?l)
        (nearLand ?l)
        (surveyComplete ?l)
        (landEmpty ?l)
        (locationKit ?s ?k)
        (strucKit ?k)
        (not (tidalPwrGen ?l))
    )

    :effect (and 
        (tidalPwrGen ?l)
        (not (locationKit ?s ?k))
        (kitEmpty ?s)
        (not (landEmpty ?l))
        (forall (?l2 - location)
            (when (path ?l ?l2) (nearTidalPwrGen ?l2))) 
        )
)

(:action buildEnrgyCable 
    :parameters (
        ?s - sub
        ?l - location
        ?p - personnel
        ?k - kits
    )
    :precondition (and 
        (not (subCrashed ?s))
        (locationSub ?s ?l)
        (not(protectedArea ?l))
        (persInSub ?s ?p)
        (engineer ?p)
        (or
            (sWater ?l)
            (dWater ?l)
        )
        (or
            (nearTidalPwrGen ?l)
            (nearCable ?l)
        )
        (surveyComplete ?l)
        (landEmpty ?l)
        (locationKit ?s ?k)
        (enrgyKit ?k)
    )
    

    :effect (and 
        (cableBuilt ?l)
        (not (landEmpty ?l))
        (forall (?l2 - location)
            (when (path ?l ?l2) (nearCable ?l2))) 
        )
)

(:action buildUWBase 
    :parameters (
        ?s1 - sub
        ?s2 - sub
        ?l - location
        ?p1 - personnel
        ?p2 - personnel
        ?k1 - kits
        ?k2 - kits
    )
    :precondition (and 
        (not(krakenThere ?l))
        (not (subCrashed ?s1))
        (not (subCrashed ?s2))
        (not (= ?s1 ?s2))
        (locationSub ?s1 ?l)
        (locationSub ?s2 ?l)
        (persInSub ?s1 ?p1)
        (engineer ?p1)
        (persInSub ?s2 ?p2)
        (engineer ?p2)
        (dWater ?l)
        (cableBuilt ?l)
        (surveyComplete ?l)
        (locationKit ?s1 ?k1)
        (strucKit ?k1)
        (locationKit ?s2 ?k2)
        (strucKit ?k2)
    )
    

    :effect (and 
        (uwBase ?l)
        (not (locationKit ?s1 ?k1))
        (kitEmpty ?s1)
        (not (locationKit ?s2 ?k2))
        (kitEmpty ?s2)
        (base ?l)
        (when (not(base1)) (base1))
        (when (base1) (base2))
)

)

(:action uploadScan 
    :parameters (
        ?s - sub
        ?b - location
        ?scanedLocation - location
        ?p - personnel
    )
    :precondition (and 
        (not (subCrashed ?s))
        (uwBase ?b)
        (locationSub ?s ?b)
        (scanComplete ?scanedLocation ?s)
    )
    
    :effect (and 
        (not (scanComplete ?scanedLocation ?s))
        (baseScnAvailable ?b ?scanedLocation)
)

)

(:action understandScan 
    :parameters (
        ?s - sub
        ?l - location
        ?scanedLocation - location
        ?p - personnel
    )
    :precondition (and 
        (not (subCrashed ?s))
        (uwBase ?l)
        (locationPers ?p ?l)
        (scientist ?p)
        (baseScnAvailable ?l ?scanedLocation)
    )
    
    :effect (and 
        (not (scanComplete ?scanedLocation ?s))
        (searchedLocation ?scanedLocation)
)

)

(:action enableShield 
    :parameters (
        ?s - sub
    )
    :precondition (and 
        (not (subCrashed ?s))
        (pilotInSub ?s)
        (shieldDisabled ?s)
    )
    
    :effect (and 
        (not (shieldDisabled ?s))
    )
)

(:action disableShield 
    :parameters (
        ?s - sub
    )
    :precondition (and 
        (not (subCrashed ?s))
        (pilotInSub ?s)
        (not (shieldDisabled ?s))
    )
    
    :effect (and 
        (shieldDisabled ?s)
)
)

(:action enableSonar 
    :parameters (
        ?b - location
        ?p - personnel
    )
    :precondition (and 
        (locationPers ?p ?b)
        (engineer ?p)
        (uwBase ?b)
        (base1)
        (base2)
    )
    
    :effect (and 
        (sonarEnabled)
    )
)

)


