class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("movie_title")
    @the_movie.year = params.fetch("movie_year")
    @the_movie.duration = params.fetch("movie_duration")
    @the_movie.description = params.fetch("movie_description")
    @the_movie.image = params.fetch("movie_image")
    @the_movie.director_id = params.fetch("movie_director")

    if @the_movie.valid?
      @the_movie.save
      redirect_to("/movies", {:notice => "Movie was created succesfully."})
    else
      redirect_to("/movies", {:notice => "Movie was not created succesfully."})
    end

  end

  def update
    movie_id = params.fetch("path_id")
    @movie = Movie.where({:id => movie_id}).at(0)
    @movie.title = params.fetch("movie_title")
    @movie.year = params.fetch("movie_year")
    @movie.duration = params.fetch("movie_duration")
    @movie.description = params.fetch("movie_description")
    @movie.image = params.fetch("movie_image")
    @movie.director_id = params.fetch("movie_director")

    if @movie.valid?
      @movie.save
      redirect_to("/movies/#{movie_id}", { :notice => "Movie updated successfully." })
    else
      redirect_to("/movies/#{movie_id}", { :notice => "Movie failed to update successfully." })
    end  

  end

  def delete
    movie_id = params.fetch("path_id")
    @movie = Movie.where({:id => movie_id}).at(0)
    @movie.destroy
    redirect_to("/movies", { :notice => "Movie deleted succesfully."})
  end

end
