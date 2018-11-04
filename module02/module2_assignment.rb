class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    self.calculate_word_frequency(@content)
  end

  def calculate_word_frequency(line)
    #a hash is like a dictionary. it has keys and values (mapping)
    frequency = Hash.new(0)
    #for each word in line, make it downcase and add 1 to frequency[word.downcase]
    line.split.each do |word|
      frequency[word.downcase] += 1
    end

    #set @highest_wf_count equal to the largest value of frequency
    @highest_wf_count = frequency.values.max
    
    #from frequency, create a new array that satisfy: value==@highest_wf_count
    #and set @highest_wf_words equal to the new array's key
    @highest_wf_words = frequency.select {|key, value| value ==@highest_wf_count}.keys
  end
end

class Solution
  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers
  def initialize()
    @analyzers = []
  end

  def analyze_file()
    #read test.txt and save its lines as array
    lines = File.foreach('test.txt')

    #insert each line into LineAnalyzer and save it into @analyzers
    lines.each_with_index do |line, index|
      @analyzers << LineAnalyzer.new(line, index)
    end
  end

  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = []

    #find the biggest value of highest_wf_count
    @analyzers.each {|analyzer| @highest_count_across_lines = analyzer.highest_wf_count if analyzer.highest_wf_count > @highest_count_across_lines}

    #find the line with the most frequent word and save its analyzer into highest_count_words_across_lines
    @analyzers.each {|analyzer| @highest_count_words_across_lines << analyzer if analyzer.highest_wf_count == @highest_count_across_lines}
  end

  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:\n"
    @highest_count_words_across_lines.each do |analyzer|
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
    end
  end  
end
