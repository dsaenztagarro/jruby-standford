# The interpreter of the analysis done by the pipeline
class Interpreter
  extend JavaHelper
  java_import edu.stanford.nlp.ling.CoreAnnotations::TokensAnnotation

  # @param sentences [
  def initialize(sentences)
    @sentences = sentences
  end

  def process(params)
    annotate(text).to_h
  end

  def execute
    return {} unless @sentences
    list = {}
    @sentences.each { |sentence| process_sentence(list, sentence) }
    list
  end

  private

  def process_sentence(list, sentence)
    sentence.get(TokensAnnotation).each do |token|
      pos = token.tag # part of speech
      list[pos] = [] unless list[pos]
      list[pos] << token.word
    end
  end
end
