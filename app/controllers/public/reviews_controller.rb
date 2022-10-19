class Public::ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    if @review.save
      redirect_to review_path(@review.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @review = Review.find(params[:id])
    if review.update(review_params)
      redirect_to review_path(@review.id)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:evaluation, :title, :text, :evaluation, :item_id)
  end

end
