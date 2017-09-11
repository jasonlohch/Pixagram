require 'rails_helper'

RSpec.describe Post, type: :model do
  
  context "validations" do
  	it "should have description and location and image and user_id" do
      should have_db_column(:description).of_type(:text)
      should have_db_column(:location).of_type(:string)
      should have_db_column(:image_file_name).of_type(:string)
      should have_db_column(:image_content_type).of_type(:string)
      should have_db_column(:image_file_size).of_type(:integer)
      should have_db_column(:user_id).of_type(:integer)
    end

    describe "validates presence of attributes" do
      it { is_expected.to validate_presence_of(:image)}
      it { is_expected.to validate_presence_of(:description)}
    end
  end

  context "associations" do
  	it { is_expected.to belong_to(:user)}
  	it { is_expected.to have_many(:comments).dependent(:destroy)}
  end
 
end
