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
    pitem = params[:item]
    puts pitem[:identified]
    if pitem[:id]
      item = Item.find(pitem[:id])
      identified_b = true
      identified_b = false if pitem[:identified] == "0"
      item.update_attributes(name: pitem[:name],
                             magic_name: pitem[:magic_name],
                             properties: pitem[:properties],
                             description: pitem[:description],
                             identified: identified_b)
      item.save
      pitem[:mode] = "edit"
      render json: pitem
    end
    "fail"
  end
  
end