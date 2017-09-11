require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do

  	it "should have name and email and password digest" do
  		should have_db_column(:name).of_type(:string)
  		should have_db_column(:email).of_type(:string)
  		should have_db_column(:password_digest).of_type(:string)
  	end

  	describe "validates presence and uniqueness of name and email" do
  		it { is_expected.to validate_presence_of(:name) }
  		it { is_expected.to validate_presence_of(:email) }
  		it { is_expected.to validate_uniqueness_of(:email) }
  	end

  	describe "validates password" do
  		it { is_expected.to validate_presence_of(:password) }
  		it { is_expected.to validate_presence_of(:password_confirmation) }
  		it { is_expected.to validate_length_of(:password).is_at_least(6) }
  		it { is_expected.to validate_confirmation_of(:password) }
  	end

  	# happy_path
  	describe "can be created when all attributes are present" do
  		When(:user) { User.create(
  			name: "Jim",
  			email: "jim@mail.com",
  			password: "123456",
  			password_confirmation: "123456"
  		)}
  		Then { user.valid? == true }
  	end

  	#unhappy_path
  	describe "cannot be created without a name" do
  		When(:user) { User.create(email: "jack@mail.com", password: "123456", password_confirmation: "123456") }
  		Then { user.valid? == false }
  	end

  	describe "cannot be created without an email" do
  		When(:user) { User.create(name: "Jack", password: "123456", password_confirmation: "123456") }
  		Then { user.valid? == false }
  	end

  	describe "cannot be created without a password" do
  		When(:user) {User.create(name: "Jack", email: "jack@mail.com") }
  		Then { user.valid? == false }
  	end

  	describe "should permit valid email only" do
  		let(:user1) { User.create(name: "John", email: "john@mail.com", password: "123456", password_confirmation:"123456") }
  		let(:user2) { User.create(name: "Jason", email: "jason.com", password: "123456", password_confirmation: "123456") }

  		it "sign up with valid email" do
  			expect(user1).to be_valid
  		end

  		it "sign up with invalid email" do
  			expect(user2).to be_invalid
  		end
  	end
  end

  context 'associations with dependency' do
  	it { is_expected.to have_many(:posts).dependent(:destroy)}
  	it { is_expected.to have_many(:comments).dependent(:destroy)}
  end
  
end
