require "db"

struct Sublist
  include DB::Serializable

  property id : String
  property title : String
  property description : String
  property author : String
  property created : Time
  property subscriptions : Array(String)

end
