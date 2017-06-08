require "pry"

class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get "/figures/new" do
    erb :"figures/new"
  end

  post "/figures" do
    @figure = Figure.new(params[:figure])
    if !params[:title][:name].empty?
      title = Title.new(params[:title])
      title.save
      @figure.titles << title
    end
    if !params[:landmark][:name].empty?
      landmark = Landmark.new(params[:landmark])
      landmark.save
      @figure.landmarks << landmark
    end
    @figure.save
    redirect "/figures"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  put "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params[:title][:name].empty?
      title = Title.new(params[:title])
      title.save
      @figure.titles << title
    end
    if !params[:landmark][:name].empty?
      landmark = Landmark.new(params[:landmark])
      landmark.save
      @figure.landmarks << landmark
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
