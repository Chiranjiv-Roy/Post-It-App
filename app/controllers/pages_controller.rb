class PagesController < ApplicationController
 
 def show
   render :file => 'public/index.html'
 end