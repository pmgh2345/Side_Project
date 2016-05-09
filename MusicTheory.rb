$chromatic = ["a","as","b","c","cs","d","ds","e","f","fs","g","gs"]

#proc constructs a scale/mode/chord
$construct = Proc.new do |indexx,scaleSize,arrayType|
  arrayType.each do |x| #we iterate over the appropriate array's intervals, say first degree of maj scale
    element = (indexx + x) % scaleSize  #adding each to the index of our starting note
    component = $chromatic[element]  #associating that index with its place in the chromatic scale
    structure.push(component) #adds each component of scale/mode/chord into new array
  end
  return structure #returns new array containing scale/mode/chord
end



class String

@indexx = $chromatic.find_index(self) #takes instance of string, finds its index in the 'chromatic' array
indexx = @indexx
majorArray = [0,2,4,5,7,9,11]

  def majorScale #will construct major scale
    scaleSize = 12
    $construct.call indexx,scaleSize,majorArray
  end
end
"c".majorScale

