class ReportedComment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
end
