require_relative 'MusicTheory3.rb'

chordArray = $output.call.split("--")
#puts chordArray

frequencies = {}

build = Proc.new do
  firstIndex = $chromatic.find_index(chordArray.first.downcase)
  chordArray.each do |x|
    index = $chromatic.find_index(x.downcase)
    if index < firstIndex
      index = (12 - (firstIndex + 1)) + index
    end
    frequencies[x] = index
  end
  frequencies.each do |x,y|
    difference = frequencies[x] - firstIndex
    frequencies[x] = difference + 12
  end
end

build.call

puts frequencies
