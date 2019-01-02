class XmlController < ApplicationController
  before_action :parse_params, only: :index
  def index
    arr = root(@num)
    data = if arr == 'error'
             { message: "Введены неверные данные"}
           else
             arr.map { |elem| { elem: elem } }
           end
    respond_to do |format|
      format.xml { render xml: data.to_xml }
      format.rss { render xml: data.to_xml }
    end
  end

  protected

  def parse_params
    @num = params[:num]
  end
end

def float?(str)
  true if Float(str) rescue false
end

def root(num)
  if float?(num) && num.to_f.positive?
    prev = rand(1..num.to_i).to_f
    curr = (prev + num.to_f / prev) / 2.0
    arr = [].push(curr)
    loop do
      arr.push(curr = (curr + num.to_f / curr) / 2.0)
      break if ((curr**2 - num.to_f) / num.to_f) < 1e-3
    end
  else
    arr = 'error'
  end
  arr = 0 if num == '0'
  arr
end
