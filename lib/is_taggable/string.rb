# http://www.jroller.com/obie/tags/unicode
class String
  def to_ascii
    # split in muti-byte aware fashion and translate characters over 127
    # and dropping characters not in the translation hash
    self.mb_chars.split('').collect { |c| (c[0] <= 127) ? c : translation_hash[c[0]] }.join
  end
    
  protected
    def translation_hash
      @@translation_hash ||= setup_translation_hash
    end
    
    def setup_translation_hash
      accented_chars   = "ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöøùúûüý".mb_chars.split('')
      unaccented_chars = "AAAAAACEEEEIIIIDNOOOOOxOUUUUYaaaaaaceeeeiiiinoooooouuuuy".split('')
  
      translation_hash = {}
      accented_chars.each_with_index { |char, idx| translation_hash[char[0]] = unaccented_chars[idx] }
      translation_hash["Æ".mb_chars[0]] = 'AE'
      translation_hash["æ".mb_chars[0]] = 'ae'
      translation_hash
    end
end