class Note

def initialize
  puts "Give me a note or a chord, please."
  $input = gets.chomp
  if $input[1] == "#"
    @key = $input[0] + $input[1]
  else
    @key = $input[0]
  end
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
  @eleventhArray = [14,17]
  @thirteenthArray = [14,17,21]
  @augArray = [0,4,8]
  @dimArray = [0,3,6]
  @indexx = @chromatic.find_index(key) #takes instance of the note class converted into string, finds its index in the 'chromatic' array
  @consolidate_array = []
  @construct = Proc.new do |array|
    @structure = []
    array.each do |x| #we iterate over the appropriate array's intervals, say first degree of maj scale, 2nd, 3rd...
      element = (@indexx + x) % scaleSize  #adding each to the index of our starting note         
      component = @chromatic[element].upcase  #associating that index with its place in the chromatic scale
      @structure.push(component) #then add each component of scale/mode/chord by this index into new array
    end
  end
  @consolidate = Proc.new do
    @consolidate_array = @consolidate_array + @structure
  end
  $output = Proc.new do
    #puts "Here it is!"
    puts @consolidate_array.join("--") #returns new array containing desired scale/mode/chord
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
  @construct.call @majorChord_array
  @consolidate.call
  self
end

def m
  @construct.call @minorChord_array
  @consolidate.call
  self
end

def aug
  @construct.call @augArray
  @consolidate.call
  self
end

def dim #this is programmed under assumption that only major chords get diminished. Alter if this proves false.
  @construct.call @dimArray
  @consolidate.call
  self
end

def min7
  @construct.call @min7_array
  @consolidate.call
  self
end

def maj7
  @construct.call @maj7_array
  @consolidate.call
  self
end

def ninth
  @construct.call @ninthArray
  @consolidate.call
  self
end

def eleventh
  @construct.call @eleventhArray
  @consolidate.call
  self
end

def thirteenth
  @construct.call @thirteenthArray
  @consolidate.call
  self
end

end

q = Note.new

# To fix the issue with the 7th, lets add a method for major 7th, then for any chords requiring 9ths or higher we will automatically include the minor 7th, and then test the length at the end to see if there is 1 note too many, and if there is we will remove the minor 7th at its index. 
#Screw what i wrote above- we should use the drop method- we say if maj7_cond then we drop the first element of the array housing the output.

#Here we will begin with the calling method for the triad part of the chord
maj7_cond = $input.include?("j")
minor_cond = ($input.count("m") == 2) || ($input.count("m") == 1 && maj7_cond == false)
aug_cond = $input.include?("+") ##Take note that we must use this notation for aug
dim_cond = $input.include?("o") #Take note that we must use this notation for dim
if minor_cond
  q.m
elsif aug_cond
  q.aug
elsif dim_cond
  q.dim
else
  q.M
end

#Now we will determine if we need to call any additional methods, or if all we need is the triad

beyond_triad = $input.include?( "7" ) || $input.include?("9") || $input.include?("1")

#Now we must figure out what to do with the 7th chord


if beyond_triad
  if maj7_cond
    q.maj7
  else
    q.min7
  end
end

#think about adding the 6th by checking to see if there is a d directly behind it (ie. to ensure that it's not an add6) and then making sure that the count of $input is greater than 2 to make sure we account for a d6 situation.

#Now we must figure out the highest degree

beyond_7th_cond = $input.include?( "9") || $input.include?("1")
thirteenthChord_cond = $input.include?("3")
eleventhChord_cond = (thirteenthChord_cond == false) && ($input.include?( "9") == false)
if beyond_7th_cond
  if thirteenthChord_cond
    q.thirteenth
  elsif eleventhChord_cond
    q.eleventh
    puts "hey"
  else
    q.ninth
  end
end

#Now we have to see if there are any modifiers

sus_cond = $input.include?("u")
flatten_cond = $input.split.drop(1).include?("b")

modifier_cond = $input.include?("6")

$output.call

