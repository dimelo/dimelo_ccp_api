module Dimelo
  class Question < Dimelo::API::Model
    include ::Dimelo::API::Common::Publishable

    attributes :id, :title, :body, :body_format, :flow_state, :score, :user_id,
               :category_id, :category_ids, :category_names, :star, :permalink,
               :created_at, :updated_at, :answers_count,
               :usefulnesses_yes_count, :usefulnesses_no_count, :ipaddr

    submit_attributes :title, :body, :category_ids, :user_id

    belongs_to :user
    belongs_to :category
    has_many :answers

  end
end
