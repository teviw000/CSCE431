class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
  end

  def emergency
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
        format.js { render js: 'window.top.location.reload(true);' }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

end
