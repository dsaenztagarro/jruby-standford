# Base class for all annotators
class Pipeline
  extend JavaHelper
  include_package 'edu.stanford.nlp.io'
  include_package 'edu.stanford.nlp.util'

  java_import java.lang.System
  java_import edu.stanford.nlp.ling.CoreAnnotations::PartOfSpeechAnnotation
  java_import edu.stanford.nlp.ling.CoreAnnotations::NamedEntityTagAnnotation
  java_import edu.stanford.nlp.ling.CoreAnnotations::TextAnnotation
  java_import edu.stanford.nlp.ling.CoreAnnotations::TokensAnnotation
  java_import edu.stanford.nlp.ling.CoreAnnotations::SentencesAnnotation
  java_import edu.stanford.nlp.ling.CoreLabel
  java_import edu.stanford.nlp.pipeline.StanfordCoreNLP
  java_import edu.stanford.nlp.pipeline.Annotation
  java_import edu.stanford.nlp.semgraph.SemanticGraphCoreAnnotations::CollapsedCCProcessedDependenciesAnnotation
  java_import edu.stanford.nlp.semgraph.SemanticGraph
  java_import edu.stanford.nlp.trees.TreeCoreAnnotations::TreeAnnotation
  java_import edu.stanford.nlp.util.logging.RedwoodConfiguration

  attr_accessor :pipeline

  def initialize
    init_properties
    disable_log do
      @pipeline = StanfordCoreNLP.new(@props)
    end
  end

  # Parse a text returning the sentences analyzed
  # @param text [String] The text to be parsed
  # @return Array[] The sentences analyzed
  def sentences_for(text)
    document = Annotation.new(text)
    pipeline.annotate(document)
    document.get(SentencesAnnotation)
  end

  private

  # Executes the block of code with default non-standard Stanford logger
  # disabled, avoiding error server logs
  def disable_log(&block)
    # shut off the annoying intialization messages
    RedwoodConfiguration.empty.capture(System.err).apply
    block.call
    # enable stderr again
    RedwoodConfiguration.current.clear.apply
  end

  # Sets annotators to be used by the stanford library during the parse process
  def init_properties
    key = 'annotators'
    value = 'tokenize, ssplit, pos, lemma, ner, parse, dcoref'
    @props = java.util.Properties.new
    @props.setProperty(key, value)
  end
end
