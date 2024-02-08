(define (problem deposit)
(:domain deposit)
; We define 3 different items, 2 types of trash bins, one table and a robot
(:objects
  table floor - location
  bottle newspaper rotten_apple - item
  walle - robot
)

; Initially everything is on the floor and robot is by the table
(:init
  (= (weight bottle) 2)
  (= (weight newspaper) 2)
  (= (weight rotten_apple) 2)
  (= (max-load walle) 3)
  (= (current-load walle) 0)

  (robot_at walle table)
  (gripper_free walle)
  (item_at bottle floor)
  (item_at newspaper floor)
  (item_at rotten_apple floor)
)

; The goal is to clean the floor!
(:goal (and
    (in_trash bottle)
    (in_trash rotten_apple)
    (in_trash newspaper)
  )
)

)
