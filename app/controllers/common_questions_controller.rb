class CommonQuestionsController < ApplicationController

  def index
    slug = CommonQuestion.slug
    question = CommonQuestion.question
    @qa = [slug, question]
  end

end
