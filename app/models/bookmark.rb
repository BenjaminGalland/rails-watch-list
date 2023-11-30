class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { in: 6..20 }
  validates :movie, uniqueness: { scope: :list }
end
