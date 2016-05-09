$chromatic = ["a","as","b","c","cs","d","ds","e","f","fs","g","gs"]

class Note
#proc constructs a scale/mode/chord
construct = Proc.new do |indexx,scaleSize,arrayType|
  arrayType.each do |x| #we iterate over the appropriate array's intervals, say first degree of maj scale, 2nd, 3rd...
    element = (indexx + x) % scaleSize  #adding each to the index of our starting note
    component = $chromatic[element]  #associating that index with its place in the chromatic scale
    structure.push(component) #then add each component of scale/mode/chord by this index into new array
  end
  return structure #returns new array containing desired scale/mode/chord
end

  def initialize
    @name = self.to_s
    name = @name
    @indexx = $chromatic.find_index(name) #takes instance of the note class, finds its index in the 'chromatic' array
    indexx = @indexx
  end

$majorArray = [0,2,4,5,7,9,11]

  def majorScale &construct #will construct major scale
    scaleSize = 12
    construct.call @indexx,scaleSize,$majorArray
    construct
    yield
  end
end

c = Note.new

c.majorScale

