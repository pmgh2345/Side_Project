class Note

$chromatic = ["a","as","b","c","cs","d","ds","e","f","fs","g","gs"]
$majorArray = [0,2,4,5,7,9,11]

def initialize
  puts "What note are we starting with?"
  @key = gets.chomp
  key = @key
  @indexx = $chromatic.find_index(key) #takes instance of the note class converted into string, finds its index in the 'chromatic' array
end

construction = Proc.new do |scaleSize,array|
  structure = []
  arrayType.each do |x| #we iterate over the appropriate array's intervals, say first degree of maj scale, 2nd, 3rd...
    element = (@indexx + x) % scaleSize  #adding each to the index of our starting note         
    component = $chromatic[element]  #associating that index with its place in the chromatic scale
    structure.push(component) #then add each component of scale/mode/chord by this index into new array
  end
  puts structure #returns new array containing desired scale/mode/chord
end

#def majorScale
  #scaleSize = 12
  #@arrayType = $majorArray
  #$construct.call
 # @structure = []
 # $majorArray.each do |x| #we iterate over the appropriate array's intervals, say first degree of maj scale, 2nd, 3rd...
  #  element = (@indexx + x) % scaleSize  #adding each to the index of our starting note
 #   component = $chromatic[element]  #associating that index with its place in the chromatic scale
 #   @structure.push(component) #then add each component of scale/mode/chord by this index into new array
  #end
  #puts @structure #returns new array containing desired scale/mode/chord
#end

end

query = Note.new
majorScale
