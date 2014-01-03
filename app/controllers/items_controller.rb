class ItemsController < ApplicationController
  
  def add
    render text: "Adding item!"
    puts "Name: #{params[:item][:name]}"
    puts "Magic name: #{params[:item][:magic_name]}"
    puts "Properties: #{params[:item][:properties]}"
    puts "Description: #{params[:item][:description]}"
    if params[:item][:identified] == "1"
      puts "Identified"
    else
      puts "Unidentified"
    end
  end
  
  def update
    render text: "Updating item #{params[:item[:id]]}"
    puts "Name: #{params[:item][:name]}"
    puts "Magic name: #{params[:item][:magic_name]}"
    puts "Properties: #{params[:item][:properties]}"
    puts "Description: #{params[:item][:description]}"
    if params[:item][:identified]
      puts "Identified"
    else
      puts "Unidentified"
    end
  end
  
end