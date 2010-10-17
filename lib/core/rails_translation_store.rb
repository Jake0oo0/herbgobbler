class RailsTranslationStore < BaseTranslationStore

  def initialize( language = "en" )
    super()
    @language = language
  end
  
  def serialize
    to_return = "#{@language}:\n"
    last_context = nil
    self.each do |context, key, value|
      whitespace_depth = 2
      context_array = context.split('/')
      context_array.each do |split_context|
        to_return << "#{build_whitespace( whitespace_depth )}#{split_context}:\n" 
        whitespace_depth += 2
      end unless context == last_context
      to_return << "#{build_whitespace( 2 + 2 * context_array.length )}#{key}: \"#{escape(value)}\"\n"
      last_context = context
    end
    
    to_return.chomp
  end

  private

  def build_whitespace( amount )
    " " * amount
  end

  private

  def escape( key )
    key.gsub( /"/, '\"' )
  end
  
end
