class MoviesController < ApplicationController
  def index

    # scope search, only works on each field independently
    if !params[:title].blank?
      @movies = Movie.title_search(params[:title])
    elsif !params[:director].blank?
      @movies = Movie.director_search(params[:director])
    elsif !params[:runtime].blank?
      @movies = Movie.search_runtime(params[:runtime])
    else 
      @movies = Movie.all 
    end
  end

  def show
    @movie = Movie.find(params[:id])

  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create 
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path(@movie), notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update 
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
      )
  end
end
