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
  @sus_number = $input.partition("sus").pop.to_i
  #puts @sus_number #to delete after troubleshooting
  @sus_array = [@majorArray[@sus_number-1]] #we can use majorarray as both m and M have same degrees for 2 and 4
  #puts @sus_array #to delete after torubleshooting
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
  @construct.call @majorArray
  @output.call
end

def minorScale
  @construct.call @minorArray
  @output.call
end

def dorian
  @construct.call @dorianArray
  @output.call
end

def phrygian
  @construct.call @phrygianArray
  @output.call
end

def lydian
  @construct.call @lydianArray
  @output.call
end

def mixolydian
  @construct.call @mixolydianArray
  @output.call
end

def locrian
  @construct.call @locrianArray
  @output.call
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

def sus
  @consolidate_array.delete_at(1)
  @construct.call @sus_array
  @consolidate.call
  @consolidate_array.insert(1,@consolidate_array.pop)
  self
end

def add (scale)
  #First we will isolate the scale degrees to be added
  addAdjust = Proc.new do |addedNote| #proc will determine whether the interval to be added is double digits and shorten if necessary
  if addedNote[1].to_i == 0
    addedNote.slice!(1)
  end
  end
  firstAdd = $input.partition("dd").pop.slice(0..1)
  addAdjust.call firstAdd
  addCount = $input.chars.count("d")
  if $addCount >= 4
    doubleAdd = true #condition says we are having to add 2 notes
    secondAdd = $input.rpartition("dd").pop.slice(0..1)
    addAdjust.call secondAdd
  end
  #Then we will adjust this scale degree to the index at which it will be found in the appropriate array
  indexAdjust = Proc.new do |whichAdd| #whichAdd will either be the first or second add
    (whichAdd.to_i - 1) % 7
  end
  if scale == "minor"
    @construct.call [@minorArray[(firstAdd.to_i-1)%7]]
    @consolidate.call
    self
  else
    @construct.call [@majorArray[indexAdjust firstAdd]]
    @consolidate.call
    self
  end
end

end

q = Note.new

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
#We will add an adjustment to input that excludes the add modifier and anything afterwards
inputAdjusted = $input.partition("add").first
beyond_triad = inputAdjusted.include?( "7" ) || inputAdjusted.include?("9") || inputAdjusted.include?("1")

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

beyond_7th_cond = inputAdjusted.include?( "9") || inputAdjusted.include?("1")
thirteenthChord_cond = inputAdjusted.include?("3")
eleventhChord_cond = (thirteenthChord_cond == false) && ($input.include?( "9") == false)
if beyond_7th_cond
  if thirteenthChord_cond
    q.thirteenth
  elsif eleventhChord_cond
    q.eleventh
  else
    q.ninth
  end
end

#Now we have to see if there are any modifiers

#Let's start with sus

sus_cond = $input.include?("u")
if sus_cond
  q.sus
end

#now we will add conditions for chords that where you have to "add" a degree

$addCount = $input.chars.count("d")
add_cond = $addCount >= 2

addProc = Proc.new do
  if minor_cond
    q.add ("minor")
  else
    q.add ("major")
  end
end

if add_cond
  addProc.call
end


flatten_cond = $input.split.drop(1).include?("b")

$output.call

