require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let!(:blog) { FactoryBot.create :blog }
  let!(:user) { FactoryBot.create :user }

  describe "GET /index" do
    it 'allow user to view the list of blogs' do
      get blogs_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'allows user to view a specific blog' do
      get blog_url(blog)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'redirects when the user is not logged in' do
      get new_blog_path
      expect(response.status).to eq 302
    end

    it 'returns a status of 200 if logged in' do
      headers =  [user.email, user.password] 
      get new_user_session_url, headers: headers
      expect(response).to be_successful
    end
  end
end
