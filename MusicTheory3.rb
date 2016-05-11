class Note

def initialize
  puts "What note are we starting with?"
  @key = gets.chomp
  key = @key
  @chromatic = ["a","a#","b","c","c#","d","d#","e","f","f#","g","g#"]
  scaleSize = 12
  @majorArray = [0,2,4,5,7,9,11]
  @minorArray = [0,2,3,5,7,8,10]
  @dorianArray = [0,2,3,5,7,9,10]
  @phrygianArray = [0,1,3,5,7,8,10]
  @lydianArray = [0,2,4,6,7,9,11]
  @mixolydianArray = [0,2,4,5,7,9,10]
  @locrianArray = [0,1,3,5,6,8,10]
  @majorChord_array = [0,4,7,11,14]
  @minorChord_array = [0,3,7,10,14]
  @indexx = @chromatic.find_index(key) #takes instance of the note class converted into string, finds its index in the 'chromatic' array
  @construct = Proc.new do |array|
    structure = []
    array.each do |x| #we iterate over the appropriate array's intervals, say first degree of maj scale, 2nd, 3rd...
      element = (@indexx + x) % scaleSize  #adding each to the index of our starting note         
      component = @chromatic[element]  #associating that index with its place in the chromatic scale
      structure.push(component) #then add each component of scale/mode/chord by this index into new array
    end
    puts "Here it is!"
    structure.each do |x| #returns new array containing desired scale/mode/chord
      print '-' + x.upcase + '-'
    end
  end
end

def majorScale
  array = @majorArray
  @construct.call array
end

def minorScale
  array = @minorArray
  @construct.call array
end

def dorian
  array = @dorianArray
  @construct.call array
end

def phrygian
  array = @phrygianArray
  @construct.call array
end

def lydian
  array = @lydianArray
  @construct.call array
end

def mixolydian
  array = @mixolydianArray
  @construct.call array
end

def locrian
  array = @locrianArray
  @construct.call array
end

def major
  array = @majorChord_array
  @construct.call array
end

def minor
  array = @minorChord_array
  @construct.call array
end

end

query = Note.new
query.major
