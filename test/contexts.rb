# require needed files
require './test/sets/animals'
require './test/sets/owners'
require './test/sets/pets'
require './test/sets/visits'


# While testing, we always already know what the answer is supposed to be
# And we would like to compare it with the answer obtained. 
# How do we know what the answer is supposed to be? 
# So, we will setup the database, so we know what are the correct answers
# For example: we know that for owners, there are 3 owners and we know their names
# And we know that only 2 of them are active, and the third is not
# we include contexts in here
module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Animals
  include Contexts::Owners
  include Contexts::Pets
  include Contexts::Visits
  
  def create_all
    create_animals
    puts "Built animals"
    create_owners
    puts "Built owners and owner users"
    create_pets
    puts "Built pets"
    create_visits
    puts "Built visits"
  end
  
end