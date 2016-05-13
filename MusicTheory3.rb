class Note

def initialize
  puts "Give me a note or a chord, please."
  $input = gets.chomp
  @key = $input[0]
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
  @majorChord_array = [0,4,7]
  @minorChord_array = [0,3,7]
  @min7_array = [10]
  @maj7_array = [11]
  @ninthArray = [14]
  @augArray = [0,4,8]
  @dimArray = [0,3,6]
  @indexx = @chromatic.find_index(key) #takes instance of the note class converted into string, finds its index in the 'chromatic' array
  @construct = Proc.new do |array|
    @structure = []
    array.each do |x| #we iterate over the appropriate array's intervals, say first degree of maj scale, 2nd, 3rd...
      element = (@indexx + x) % scaleSize  #adding each to the index of our starting note         
      component = @chromatic[element].upcase  #associating that index with its place in the chromatic scale
      @structure.push(component) #then add each component of scale/mode/chord by this index into new array
    end
  end
  @maj7th_fix = Proc.new do |threshold|
    if @structure.length > threshold
      @structure.delete_at(4)
    end
  end
  @output = Proc.new do
    #puts "Here it is!"
    puts @structure.join("--") #returns new array containing desired scale/mode/chord
  end
end

def majorScale
  array = @majorArray
  @construct.call array
  @output.call
end

def minorScale
  array = @minorArray
  @construct.call array
  @output.call
end

def dorian
  array = @dorianArray
  @construct.call array
  @output.call
end

def phrygian
  array = @phrygianArray
  @construct.call array
  @output.call
end

def lydian
  array = @lydianArray
  @construct.call array
  @output.call
end

def mixolydian
  array = @mixolydianArray
  @construct.call array
  @output.call
end

def locrian
  array = @locrianArray
  @construct.call array
end

def M
  array = @majorChord_array
  @construct.call array
  @output.call
  self
end

def m
  array = @minorChord_array
  @construct.call array
  @output.call
  self
end

def aug
  array = @augArray
  @construct.call array
  @output.call
  self
end

def dim #this is programmed under assumption that only major chords get diminished. Alter if this proves false.
  array = @dimArray
  @construct.call array
  @output.call
  self
end

def min7
  array = @min7_array
  @construct.call array
  @output.call
  self
end

def maj7
  array = @maj7_array
  @construct.call array
  @output.call
  self
end

def ninth
  array = @ninthArray
  @construct.call array
  @output.call
  threshold = 5
  @maj7th_fix.call threshold
  self
end

end

q = Note.new

# To fix the issue with the 7th, lets add a method for major 7th, then for any chords requiring 9ths or higher we will automatically include the minor 7th, and then test the length at the end to see if there is 1 note too many, and if there is we will remove the minor 7th at its index. 
#Screw what i wrote above- we should use the drop method- we say if maj7_cond then we drop the first element of the array housing the output.

#Here we will begin with the calling method for the triad part of the chord

minor_cond = ($input.count("m") == 2) || ($input.count("m") == 1 && maj7_cond == false)
aug_cond = $input.include?("+")
dim_cond = $input.include?("o")
if minor_cond
  q.m
elsif aug_cond
  q.aug
elsif dim_cond
  q.dim
end

#Now we will determine if we need to call any additional methods, or if all we need is the triad

beyond_triad = $input.include?("7" || "9" || "1")

#Now we must figure out what to do with the 7th chord
maj7_cond = $input.include?("j")
if beyond_triad
  if maj7_cond
    q.maj7
  else
    q.min7
  end
end

#Now we must figure out if we go higher than a 9th chord




