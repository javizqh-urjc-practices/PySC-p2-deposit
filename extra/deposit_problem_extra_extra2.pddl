(define (problem deposit2)
(:domain deposit2)
; We define 3 different items, 2 types of trash bins, one table and a robot
(:objects
  table floor - location
  bottle newspaper rotten_apple - item
  walle eva - robot
)

; Initially everything is on the floor and robot is by the table
(:init
  (= (weight bottle) 2)
  (= (weight newspaper) 1)
  (= (weight rotten_apple) 1)
  (= (max-load walle) 6)
  (= (current-load walle) 0)

  (= (distance table floor) 10)
  (= (distance floor table) 10)
  (= (distance table large-deposit) 40)
  (= (distance large-deposit table) 40)
  (= (distance floor large-deposit) 50)
  (= (distance large-deposit floor) 50)


  (robot_at walle table)
  (gripper_free walle)
  (robot_at eva floor)
  (gripper_free eva)
  (robot_tall eva)
  (robot_vacuum walle)
  (can_pick eva table)
  (can_pick walle floor)
  (item_at bottle table)
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
