(define (problem deposit)
(:domain deposit)
; We define 3 different items, 2 types of trash bins, one table and a robot
(:objects
  table floor - location
  large-deposit - location
  bottle newspaper rotten_apple - item
  walle - robot
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
  (item_at bottle floor)
  (item_at newspaper floor)
  (item_at rotten_apple floor)
)

; The goal is to clean the floor!
(:goal (and
    (item_at bottle large-deposit)
    (item_at rotten_apple large-deposit)
    (item_at newspaper large-deposit)
  )
)

)
