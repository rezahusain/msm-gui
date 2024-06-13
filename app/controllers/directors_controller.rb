class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    @director = Director.new
    @director.name = params.fetch("director_name")
    @director.dob = params.fetch("director_dob")
    @director.bio = params.fetch("director_bio")
    @director.image = params.fetch("director_image")

    if @director.valid?
      @director.save
      redirect_to("/directors", { :notice => "Director created successfully." })
    else
      redirect_to("/directors", { :notice => "Director failed to create successfully." })
    end  
  end

  def update
    director_id = params.fetch("path_id")
    @director = Director.where({:id => director_id}).at(0)
    @director.name = params.fetch("director_name")
    @director.dob = params.fetch("director_dob")
    @director.bio = params.fetch("director_bio")
    @director.image = params.fetch("director_image")

    if @director.valid?
      @director.save
      redirect_to("/directors/#{director_id}", { :notice => "Director updated successfully." })
    else
      redirect_to("/directors/#{director_id}", { :notice => "Director failed to update successfully." })
    end  

  end

  def delete
    director_id = params.fetch("path_id")
    @director = Director.where({:id => director_id}).at(0)
    @director.destroy
    redirect_to("/directors", { :notice => "Director deleted succesfully."})
  end

end
