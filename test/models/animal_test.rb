require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
  # Not much for testing Animal as it is a simple model

  # Should offered in the Shoulda gem
  # have_many () a relationship matcher offered in the Shoulda-matchers gem
  should have_many(:pets)
  
  # Validation matchers...
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  # Valid Format test
  # valid cases
  should allow_value("Cat").for(:name)
  should allow_value("Dog").for(:name)
  should allow_value("Bird").for(:name)
  # invalid cases
  should_not allow_value("bird").for(:name)
  should_not allow_value("a").for(:name)
  should_not allow_value("1234").for(:name)

  # Testing the remaining parts: these do not have shoulda matchers 
  # They require a set of examples to be test against
  # That's where the context is needed
    context "Creating animals context" do
    # create the objects I want with factories
    setup do 
      puts "setting up the context"
      create_animals
    end
    
    # and provide a teardown method as well
    teardown do
      destroy_animals
    end
  
    # now run the tests:
    # test the scope 'alphabetical'
    should "shows that animals are listed in alphabetical order" do
      assert_equal ["Bird", "Cat", "Dog", "Ferret", "Rabbit", "Turtle"], Animal.alphabetical.map{|a| a.name}
    end
    
    # test the scope 'active'
    should "shows that there are five active animals" do
      assert_equal 5, Animal.active.size
      # assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
      assert_equal ["Bird", "Cat", "Dog", "Ferret", "Rabbit"], Animal.active.map{|a| a.name}.sort
    end

    # test the scope 'inactive'
    should "shows that there is one inactive animal" do
      assert_equal 1, Animal.inactive.size
      # assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
      assert_equal ["Turtle"], Animal.inactive.map{|a| a.name}.sort
    end

    should "make sure animals cannot be destroyed" do
      deny @cat.destroy
      deny @rabbit.destroy
    end

    should "allow an existing animal to be edited" do
      @cat.active = false
      assert @cat.valid?
    end

  end
end
