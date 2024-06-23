require "db"

SUBLIST_VIEW_SQL = ->(sublist_id : String) {
  "SELECT cv.*
   FROM channel_videos cv
   WHERE EXISTS (
     SELECT 1
     FROM sublists s
     WHERE cv.ucid = ANY (s.subscriptions)
     AND s.id = '#{sublist_id}'
   )
   ORDER BY published DESC"
}

struct Sublist
  include DB::Serializable

  property id : String
  property title : String
  property description : String
  property author : String
  property created : Time
  property subscriptions : Array(String)

end

def create_sublist(title, description, user)
  slid = "IVSL#{Random::Secure.urlsafe_base64(24)[0, 31]}"
  sublist = Sublist.new({
    title: title,
    id: slid,
    author: user.email,
    description: description,
    created: Time.utc,
    subscriptions: [] of String,
  })
  Invidious::Database::Sublists.insert(sublist)
  return sublist
end
