module Dimelo::CCP
  class PrivateMessage < Dimelo::CCP::API::Model

    attributes :id, :title, :body, :html_body, :raw_body, :from_user_id, :to_user_id, :parent_id, :root_id, :created_at, :updated_at
    submit_attributes :title, :body, :from_user_id, :to_user_id, :parent_id

  end
end
