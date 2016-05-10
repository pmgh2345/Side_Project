class Note

def initialize
  puts "What note are we starting with?"
  @key = gets.chomp
  key = @key
  @chromatic = ["a","as","b","c","cs","d","ds","e","f","fs","g","gs"]
  @majorArray = [0,2,4,5,7,9,11]
  @minorArray = [0,2,3,5,7,8,10]
  @indexx = @chromatic.find_index(key) #takes instance of the note class converted into string, finds its index in the 'chromatic' array
  @construct = Proc.new do |scaleSize,array|
    structure = []
    array.each do |x| #we iterate over the appropriate array's intervals, say first degree of maj scale, 2nd, 3rd...
      element = (@indexx + x) % scaleSize  #adding each to the index of our starting note         
      component = @chromatic[element]  #associating that index with its place in the chromatic scale
      structure.push(component) #then add each component of scale/mode/chord by this index into new array
    end
    puts structure #returns new array containing desired scale/mode/chord
  end
end

def majorScale
  scaleSize = 12
  array = @majorArray
  @construct.call scaleSize, array
end

def minorScale
end

end

query = Note.new
query.majorScale
