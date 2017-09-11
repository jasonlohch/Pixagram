require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_params) {{ name: "Jimmy", email: "jimmy@mail.com", password: "123456", password_confirmation: "123456"}}
  let(:invalid_params) {{ name: "Jimmy", email: "jimmy.com", password: "123456", password_confirmation: "123456"}}
  let(:valid_params_update) {{ name: "Jimmy Jones", email: "jimmyjones@mail.com", password: "123456", password_confirmation: "123456"}}
  let(:invalid_params_update) {{ name: "Jimmy Jones", email: "jimmyjones.com", password: "123456", password_confirmation: "123456"}}

  let(:user){User.create(valid_params)}
  let(:user1){User.create(name: "Johnny", email: "johnny@mail.com", password: "123456", password_confirmation: "123456")}

  describe "GET #new" do
  	before do
  	  get :new
  	end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template('new')
    end

    it "assigns instance user" do
      expect(assigns[:user]).to be_a User
    end
  end

  describe "POST #create" do
  	#happy_path
  	context "valid_params" do
  	  it "creates new user if params are correct" do
  	  	expect {post :create, params:{:user => valid_params}}.to change(User, :count).by(1)
  	  end

  	  it 'redirects to user path and display flash notice after user created succesfully' do
  	    post :create, params:{user: valid_params}
  	    expect(response).to redirect_to(User.last)
  	    expect(flash[:success]).to eq "Welcome to Pixagram"
  	  end 
  	end

  	context "invalid_params" do
  	  before do
  	  	post :create, params:{user: invalid_params}
  	  end

  	  it "display flash alert message" do
  	  	expect(flash[:alert]).to include "Error creating account"
  	  end

  	  it "renders new template again" do
  	  	expect(response).to render_template("new")
  	  end
  	end
  end

  describe "GET #edit" do
  	before do
  	  session[:user_id] = user.id
  	  get :edit, params:{:id => user.to_param}	
  	end

  	it "returns http success" do
  	  expect(response).to have_http_status(:success)
  	end

  	it "renders the edit template" do
  	  expect(response).to render_template("edit")
  	end
  end

  describe "PUT #update" do
    #happy path
    context "with valid update params" do
      it "updates the requested user" do
      	user = user1
      	put :update, params:{:id => user.to_param, :user => valid_params_update}
      	user.reload
      	expect( user.email ).to eq valid_params_update[:email]
      end

      it 'redirects to user path and display flash notice after user profile is succesfully updated' do
      	put :update, params:{:id => user.to_param, :user =>valid_params_update}
      	user.reload
      	expect(response).to redirect_to(user_path(user))
      	expect(flash[:success]).to eq "Profile updated"
      end
    end

    #unhappy path
    context "with invalid update params" do
      it "re-renders the 'edit' template" do
      	put :update, params:{:id => user.to_param, :user => invalid_params_update}
      	expect(response).to render_template("edit")
      end	
    end
  end

end
