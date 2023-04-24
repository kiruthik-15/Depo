class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = @movie.reviews.includes(:user).paginate(page: params[:page])
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = @movie.reviews.new
  end

  # GET /reviews/1/edit
  def edit
    authorize! :update, @review
  end

  # POST /reviews or /reviews.json
  def create
    @review = @movie.reviews.new(review_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @review.save
        format.html { redirect_to movie_reviews_url(@movie,@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to movie_review_url(@movie,@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    authorize! :destroy, @review
    @review.destroy

    respond_to do |format|
      format.html { redirect_to movie_reviews_url(@movie,@review), notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end
    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :comment, :user_id, :movie_id)
    end
end
