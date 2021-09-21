require 'rails_helper'

RSpec.describe "Blogs", type: :request do

  describe "GET /index" do
    it 'allow user to view the list of blogs' do
      get blogs_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:blog) { create(:blog) }

    it 'allows user to view a blog' do
      get blog_url(blog)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    context 'when with no authenticated user' do
      it 'redirects when the user is not logged in' do
        get new_blog_path
        expect(response).to_not be_successful
      end
    end

    context 'when with authenticated user' do
      let(:user) { create(:user) }

      before do
        sign_in(user)
      end

      it 'allows blog entry' do
        get new_blog_path
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /create' do
    let(:user) { create(:user) }
    let(:valid_attributes) do
      {
        'title' => Faker::Book.title, 
        'body' => Faker::Lorem.paragraphs,
        'user_id' => user.id
      }
    end

    context 'when with authenticated user' do
      before do
        sign_in(user)
      end

      it 'allows user to create a new blog' do
        expect do
          blog = Blog.new(valid_attributes)
          blog.save
          post blogs_path, params: { blog: valid_attributes }
        end.to change(Blog, :count).by(1)
      end
    end

    context 'when with no authenticated user' do
      it 'will redirect to log in' do
          blog = Blog.new(valid_attributes)
          blog.save
          post blogs_path, params: { blog: valid_attributes }
          expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
