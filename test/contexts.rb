# While testing, we always already know what the answer is supposed to be
# And we would like to compare it with the answer obtained. 
# How do we know what the answer is supposed to be? 
# So, we will setup the database, so we know what are the correct answers
# For example: we know that for owners, there are 3 owners and we know their names
# And we know that only 2 of them are active, and the third is not
# we include contexts in here
module Contexts

  def create_animals
    @cat    = FactoryBot.create(:animal) #this creates an animal named Cat, and having active equal to true, as per factory
    @dog    = FactoryBot.create(:animal, name: 'Dog')
    @bird   = FactoryBot.create(:animal, name: 'Bird')
    @ferret = FactoryBot.create(:animal, name: 'Ferret')
    @rabbit = FactoryBot.create(:animal, name: 'Rabbit')
    @turtle = FactoryBot.create(:animal, name: 'Turtle', active: false)
  end
  
  def destroy_animals
    @cat.delete  
    @dog.delete
    @bird.delete
    @ferret.delete
    @rabbit.delete
    @turtle.delete
  end

  def create_owners
    @alex = FactoryBot.create(:owner)
    @rachel = FactoryBot.create(:owner, first_name: "Rachel", active: false)
    @mark = FactoryBot.create(:owner, first_name: "Mark", phone: "412-268-8211")
  end
  
  def destroy_owners
    @rachel.delete
    @mark.delete
    @alex.delete
  end


  def create_pets
    @dusty = FactoryBot.create(:pet, animal: @cat, owner: @alex, female: false)
    @polo = FactoryBot.create(:pet, animal: @cat, owner: @alex, name: "Polo", active: false)
    @pork_chop = FactoryBot.create(:pet, animal: @dog, owner: @mark, name: "Pork Chop")
  end
  
  def destroy_pets
    @dusty.delete
    @polo.delete
    @pork_chop.delete
  end


  def create_visits
    @visit1 = FactoryBot.create(:visit, pet: @dusty)
    @visit2 = FactoryBot.create(:visit, pet: @polo, date: 5.months.ago.to_date)
    @visit3 = FactoryBot.create(:visit, pet: @polo, date: 2.months.ago.to_date)    
  end
  
  def destroy_visits
    @visit1.delete
    @visit2.delete
    @visit3.delete
  end


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
  
  def destroy_all
    destroy_animals
    puts "Animals destroyed"
    destroy_visits
    puts "Visits destroyed"
    destroy_pets
    puts "Pets destroyed"
    destroy_owners
    puts "Owners destroyed"

  end

end #end of context