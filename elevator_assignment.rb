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
  attr_accessor :occupied, :current_floor, :total_trips, :direction

  def initialize
    @occupied = false
    @current_floor = 1
    @total_trips = 0
    @direction = 'stopped'
  end

  def door_opening
    puts 'Door opening'
  end

  def door_closing
    puts 'Door closing'
  end

  def current_floor(floor)
    @current_floor = floor
    puts floor
  end

  def floor_reporting(starting_floor, ending_floor, direction)
    # Announces each floor passed
    if direction == 'down'
      starting_floor.downto(ending_floor){|floor| current_floor(floor)}
    else
      (starting_floor..ending_floor).each{|floor| current_floor(floor)}
    end
  end

  def call(starting_floor, ending_floor, direction)
    door_opening
    door_closing
    @occupied = true
    @direction = direction
    floor_reporting(starting_floor, ending_floor, direction)
    door_opening
    door_closing
    @occupied = false
    @total_trips += 1
    @direction = 'stopped'
  end

  def occupied?
    @occupied
  end

  def floor
    @current_floor
  end

  def direciton
    @direction
  end

  def in_service?
    @total_trips < 100 ? true : false
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
    @number_of_elevators.times{ @elevators << Elevator.new }
  end

  def elevator_on_floor(floor)
    # Checks elevators array to see if any are currently stopped on the given floor
    elevators_on_floor = []
    @elevators.each do |elevator|
      if elevator.occupied? == false && elevator.floor == floor
        elevators_on_floor << elevator
      end
    end
    elevators_on_floor.length > 0 ? elevators_on_floor[0] : false
  end

  def coming_this_way?(elevator, floor)
    if elevator.direction == 'up' && elevator.floor < floor
      true
    elsif elevator.direction == 'down' && elevator.floor > floor
      true
    else
      false
    end
  end

  def on_the_move(floor, direction)
    # Checks elevators array to see if any are occupied and will pass the floor
    elevators_coming = []
    @elevators.each do |elevator|
      if elevator.coming_this_way?
        elevators_coming << elevator
      end
    end
    elevators_coming.length > 0 ? elevators_coming[0] : false
  end

  def closest_unoccupied(floor)
    # Checks elevators array to find closest unoccupied elevator
    closest_elevator = ''
    floors_away = @number_of_floors
    @elevators.each do |elevator|
      if floors_away > (elevator.floor - floor).abs
        closest_elevator = elevator
        floors_away = (elevator.floor - floor).abs
      end
    end
    closest_elevator
  end

  def elevator_call(floor, direction)
    # Returns an elevator based on above listed priorities
    if elevator_on_floor(floor) == false && on_the_move(floor, direction) == false
      closest_unoccupied(floor)
    elsif elevator_on_floor == false
      on_the_move(floor, direction)
    else
      elevator_on_floor
    end
  end
end
