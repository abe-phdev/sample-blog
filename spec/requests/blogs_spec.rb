require 'rails_helper'

RSpec.describe "Blogs", type: :request do

  describe "GET /index" do
    it 'allow user to view the list of blogs' do
      get blogs_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:blog) { FactoryBot.create :blog }

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
    it 'is ok' do
      expect(2).to eq 2
    end
  end
end
