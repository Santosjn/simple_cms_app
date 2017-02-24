class Utils

  def self.random_hash(size: nil)
  	size = 50 if !size
    v = [(0..9),('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    string = (0...size).map { v[rand(v.length)] }.join
  end

end
