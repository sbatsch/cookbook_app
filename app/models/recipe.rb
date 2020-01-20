class Recipe < ApplicationRecord
  def ingredients_list
    ingredients.split(',')
  end 

  def directions_list
    directions.split(',')
  end

  def friendly_created_at
    created_at.strftime("%b %d, %Y")
  end

  def friendly_prep_time
    #input: time as integer of minutes, source: reader method of prep time, example: 125
    #output: String message, example: "2 hours, 5 minutes"
    hours = prep_time / 60
    minutes = prep_time % 60
    time_message = ""

    if hours > 0
       time_message += "#{hours} #{'Hour'.pluralize(hours)}"
    end 

    if hours > 0 && minutes > 0
      time_message += ","
    end 

    if minutes >0 
      time_message += "#{minutes} #{'Minute'.pluralize(minutes)}"
    end 

    time_message

  end 
end
