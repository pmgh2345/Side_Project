module Wraparound
  def wrap(size,index)
    if (size-index) >= (size/2)
      
    else
      false
    end
  end
end

chromatic = ["a","as","b","c","cs","d","ds","e","f","fs","g","gs"]

adjust = proc.new do |index,scalesize,interval| #proc decides whether the array will need to wrap around or not when applying an interval
      if (interval+index) > (size)
        return index-size
      else
        return interval+index
      end
end

class Scale

  include Wraparound

  def initialize 
    puts "What key will we be in?"
    key = gets.chomp.downcase!
    puts "What scale would you like?"
    scaleType = gets.chomp.downcase!
    @key = key
    @scaleType = scaleType
    @index = chromatic.index[key]
    scaleSize = 7
  end

  def getScale
    if @scaleType == "major"
      @scale = []
      majorProgression = [2,2,1,2,2,2,1]
      until scale.length == 7
	interval = majorProgression[scale.length]
        adjust.call (@index,scaleSize,interval)
	
      
      

  def int
    puts "What interval do you want?"
    interval = gets.chomp
    @interval = interval.to_i
    if wrap(size,@interval)
  end

  def major
    @scale = [a,as,b,c,cs,d,ds,e,f,fs,g,gs]
  end  
   

end

myKey = Theory.new


