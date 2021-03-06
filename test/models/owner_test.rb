require 'test_helper'

class OwnerTest < ActiveSupport::TestCase
  # Start by using ActiveRecord macros
  # Relationship macros...
  should have_many(:pets)
  should have_many(:visits).through(:pets)
  
  # Validation macros...
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_presence_of(:phone)
  
  # Validating email...
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  # Validating phone...
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  
  # Validating zip...
  should allow_value("15217").for(:zip)
  should allow_value("15090").for(:zip)
  should allow_value("30431").for(:zip)
  
  should_not allow_value("fred").for(:zip)
  should_not allow_value("3431").for(:zip)
  should_not allow_value(".15213").for(:zip)
  should_not allow_value("15d32").for(:zip)
  
  # Validating state...
  should allow_value("PA").for(:state)
  should allow_value("WV").for(:state)
  should allow_value("OH").for(:state)
  should_not allow_value("bad").for(:state)
  should_not allow_value(10).for(:state)
  should_not allow_value("xxx").for(:state)
  
  # ---------------------------------
  # Testing other methods with a context
  context "Creating three owners" do
    # create the objects I want with factories
    setup do 
      create_owners
    end
    
    # and provide a teardown method as well
    teardown do
      destroy_owners
    end
  
    # now run the tests:
    # test one of each factory (not really required, but not a bad idea)
    should "show that all factories are properly created" do
      assert_equal "Alex", @alex.first_name
      assert_equal "Mark", @mark.first_name
      assert_equal "Rachel", @rachel.first_name
      assert @alex.active
      assert @mark.active
      deny @rachel.active
    end
    
    # test the scope 'alphabetical'
    should "shows that there are three owners in in alphabetical order" do
      assert_equal ["Alex", "Mark", "Rachel"], Owner.alphabetical.map{|o| o.first_name}
    end
    
    # test the scope 'active'
    should "shows that there are two active owners" do
      assert_equal 2, Owner.active.size
      # assert_equal ["Alex", "Mark"], Owner.active.alphabetical.map{|o| o.first_name}
      assert_equal ["Alex", "Mark"], Owner.active.map{|o| o.first_name}.sort
    end

    # test the scope 'inactive'
    should "shows that there is one inactive owners" do
      assert_equal 1, Owner.inactive.size
      assert_equal ["Rachel"], Owner.inactive.map{|o| o.first_name}.sort
    end
    
    # test the scope 'search'
    should "shows that search for owner by either (part of) last or first name works" do
      assert_equal 3, Owner.search("Hei").size
      assert_equal 1, Owner.search("Mark").size
      assert_equal 1, Owner.search("Ra").size
    end
    
    # test the method 'name' works
    should "shows that name method works" do
      assert_equal "Heimann, Alex", @alex.name
    end
    
    # test the method 'proper_name' works
    should "shows that proper_name method works" do
      assert_equal "Alex Heimann", @alex.proper_name
    end
    
    # test the callback is working 'reformat_phone'
    should "shows that Mark's phone is stripped of non-digits" do
      assert_equal "4122688211", @mark.phone
    end
    
       # test the make_active method
       should "make Owner active" do 
        owner=FactoryBot.build(:owner, first_name: "Houda", last_name: "Bouamor", active: false)
        owner.make_active
        assert owner.active
      end 
      

    
    should "Owner never be destroyed" do
      assert !@alex.destroy
      # or
      deny @alex.destroy #the deny method is defined in test_helper.rb
    end
    
    should "make an owner and her pets inactive instead of being destroyed" do
      create_animals
      create_pets
      assert @alex.active
      assert_equal @alex.pets.active.count, 1
      @alex.destroy
      @alex.reload #Reloads the attributes of this object from the database with updated values
      deny @alex.active
      assert_equal @alex.pets.active.count, 0
      destroy_pets
      destroy_animals
    end
    
    
    # another way for testing the inclusion validation
    should "validate the state is one of the 50 states" do
      # the good are good...
      valid_states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
      valid_states.each do |state|
        @alex.state = state
        assert @alex.valid?
      end
      # ... and the bad are bad
      invalid_states = ["ALK", "AP", "TE", "D", "50th", "xxxx", 3, 0.51]
      invalid_states.each do |state|
        @alex.state = state
        deny @alex.valid?
      end

    end


  end
end
