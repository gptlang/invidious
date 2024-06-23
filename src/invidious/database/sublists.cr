require "./base.cr"

module Invidious::Database::Sublists
  extend self

  def insert(sublist: Sublist)
    sublist_array = sublist.to_a

    request = <<-SQL
      INSERT INTO sublists
      VALUES (#{arg_array(sublist_array)})
    SQL

    PG_DB.exec(request, args: sublist_array)
  end

  def delete(id : String)
    request = <<-SQL
      DELETE FROM sublists *
      WHERE id = $1
    SQL

    PG_DB.exec(request, id)
  end

  def update_subscriptions(sublist: Sublist)
    request = <<-SQL
      UPDATE sublists
      SET subscriptions = $1
      WHERE id = $2
    SQL

    PG_DB.exec(request, sublist.subscriptions, sublist.id)
  end

  def subscribe_channel(sublist : Sublist, ucid : String)
    request = <<-SQL
      UPDATE sublists
      SET subscriptions = array_append(subscriptions,$1)
      WHERE id = $2
    SQL

    PG_DB.exec(request, ucid, sublist.id)
  end

  def unsubscribe_channel(sublist : Sublist, ucid : String)
    request = <<-SQL
      UPDATE sublists
      SET subscriptions = array_remove(subscriptions, $1)
      WHERE id = $2
    SQL

    PG_DB.exec(request, ucid, sublist.id)
  end
end
