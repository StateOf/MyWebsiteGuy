require 'rails_helper'

describe WelcomeController do
  describe 'GET #index' do
    context 'the quotes in the index action render and index page renders' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template("index")
      end

      it 'should have an array of quotes' do
        get :index
        expect(assigns(:quotes)).to eq (
          { "Cayla Hayes" => "gCamp has changed my life! It's the best tool I've ever used.",
            "Leta Jaskolski" => "Before gCamp I was a disorderly slob. Now I'm more organized than I've ever been.",
            "Lavern Upton" => "Don't hesitate - sign up right now! You'll never be the same."}
        )
      end
    end
  end
end
