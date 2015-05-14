# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  source_name :string
#  name        :text
#  data        :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module EventuallyToolkit
  class Event < ActiveRecord::Base
  end
end
