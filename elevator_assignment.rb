# Challenge started at 2:40
# Initialize simulation with desired number of elevators and floors
# Elevator reports as it moves from floor to floor
# Elevator reports when it's door opens or closes
# Cannot proceed above top floor
# Cannot proceed below ground floor
# When request is made, elevator priority is:
# 1) If an elevator is stopped on the floor
# 2) If an occupied elevator is moving and will pass that floor
# 3) Closest unoccupied elevator
# Elevator keeps track of number of trips and floors it has passed
# Elevator goes in to maintenance mode after 100 trips and makes no calls

# Elevator has number of trips and floors passed
# @occupied variable -> stores true or false
# @current_floor variable -> stores floor elevator is passing/stopped on
# @total_trips variable -> stores the number of trips elevator has taken
class Elevator
  attr_accessor :occupied, :current_floor, :total_trips

  def initialize
    @occupied = false
    @current_floor = 1
    @total_trips = 0
  end

  def door_opening
    # Announces door opening
  end

  def door_closing
    # Announces door closing
  end

  def floor_reporting(starting_floor, ending_floor, direction)
    # Announces each floor passed
  end

  def call(starting_floor, ending_floor, direction)
    # Calls door_opening
    # Calls door_closing
    # Sets occupied variable to true
    # Announces each floor from starting floor to ending floor (ascending or descending)
    # Calls door_opening
    # Calls door_closing
    # Sets occupied variable to false
  end

  def occupied?
    # Returns occupied variable
  end

  def current_floor
    # Returns current_floor variable
  end

  def in_service?
    # Returns true if the @total_trips variable is < 100
  end
end

# A building takes number_of_floors and number_of_elevators
# Keeps track of which floor a call came from
# Keeps track of occupied elevators
class Building
  attr_accessor :number_of_floors, :number_of_elevators, :elevators

  def initialize(floors, elevators)
    @number_of_floors = floors
    @number_of_elevators = elevators
    @elevators = []
  end

  def elevators
    # Using @number_of_elevators builds instantiates that number of elevators and
    # Stores them in an array
  end

  def elevator_on_floor(floor)
    # Checks elevators array to see if any are currently stopped on the given floor
  end

  def elevator_call(starting_floor, ending_floor, direction)
    # Returns an elevator based on above listed priorities
  end
end
